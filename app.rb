require "zip"
require 'nokogiri'
require 'open-uri'
require 'redis'
require 'fileutils'

class Scraper
  
  attr_accessor :target, :redis_list

  def initialize
    @r = Redis.new
    @target = target
  end
  
  def create_folders
    folder = "#{DateTime.now.to_time.to_i}_" + "#{@target}".split('/').last
    @download = "bin/#{folder}_download"
    @data = "bin/#{folder}_data"
  end
  
  def download_files
    FileUtils.mkdir_p @download
    urls = []
    page = Nokogiri::HTML(open(@target))
    page.xpath('//a/@href').each do |links|
      urls << links.content
    end
    puts "Downloading files from #{@target}..."
    urls.each do |url|
      if url.split(".").last == "zip"
        download = open("#{@target}#{url}")
        IO.copy_stream(download, "#{@download}/#{url}")
        puts "Downloaded #{url}..."
      end
    end
  end
  
  def extract_zip_files
    FileUtils.mkdir_p @data
    dir = Dir["#{@download}/*.zip"]
    puts "\nPlease wait..."
    puts "Extracting zip files from #{@download}..."
    dir.each do |d|
      Zip::File.open(d) do |zip_file|
        zip_file.each do |f|
          f.extract("#{@data}/#{f}") { true }
          puts "Extracted #{zip_file}..."
        end
      end
    end
  end
  
  def to_redis
    dir = Dir["#{@data}/*.xml"]
    puts "\nPlease wait..."
    puts "Uploading contents of data directory to '#{@redis_list}'..."
    dir.each do |f|
      xmldoc = Nokogiri::XML(File.open(f))
      @r.sadd "#{@redis_list}", "#{xmldoc}"
    end
  end
  
end
