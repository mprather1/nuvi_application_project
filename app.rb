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
      `wget -r -nc -np -l 1 -A zip -P "./temp" "#{@target}#{url}"`
    end
  end
  
  def extract_zip_files
    dir = Dir["temp/" + @target.split("//")[1] + "*.zip"]
    dir.each do |d|
      Zip::File.open(d) do |zip_file|
        zip_file.each do |f|
          f.extract("data/#{f}") { true }
        end
      end
    end
  end
  
  def to_redis
    Dir["data/*.xml"].each do |f|
      xmldoc = Nokogiri::XML(File.open(f))
      @r.sadd "NEWS_XML", "#{xmldoc}"
    end
  end
  
end
