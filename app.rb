require "zip"
require 'nokogiri'
require 'open-uri'
require 'redis'

class Scraper
  
  attr_accessor :target

  def initialize
    @r = Redis.new
    @target = target
  end
  
  def download_files
    urls = []
    page = Nokogiri::HTML(open(@target))
    page.xpath('//a/@href').each do |links|
      urls << links.content
    end
    urls.each do |url|
      if url.split(".")[1] == "zip"
        download = open("#{@target}#{url}")
        IO.copy_stream(download, "temp/#{url}")
        puts "Downloaded #{url}..."
      end
    end
  end
  
  def extract_zip_files
    dir = Dir["temp/*.zip"]
    dir.each do |d|
      Zip::File.open(d) do |zip_file|
        zip_file.each do |f|
          f.extract("data/#{f}") { true }
          puts "Extracted #{f}..."
        end
      end
    end
  end
  
  def to_redis
    Dir["data/*.xml"].each do |f|
      xmldoc = Nokogiri::XML(File.open(f))
      @r.sadd "NEWS_XML", "#{xmldoc}"
      puts "Uploaded contents of #{f} to Redis..."
    end
  end
  
end
