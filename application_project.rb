require "zip"
require 'nokogiri'
require 'open-uri'
require 'redis'

class Application
  
  attr_accessor :urls
  attr_reader :dir, :target
  
  def initialize
    @r = Redis.new
    @urls = []
    @target = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"
    @dir = Dir["temp/" + @target.split("//")[1] + "*.zip"]
  end
  
  def download_files
    page = Nokogiri::HTML(open(@target))
    page.xpath('//a/@href').each do |links|
      @urls << links.content
    end
    @urls.each do |url|
      `wget -r -nc -np -l 1 -A zip -P "./temp" "#{@target}#{url}"`
    end
  end
  
  def extract_zip_files
    @dir.each do |d|
      Zip::File.open(d) do |zip_file|
      zip_file.each do |f|
        f.extract("data/#{f}") { true }
      end
    end
  end
  
  def import_to_redis
    Dir["data/*.xml"].each do |f|
      xmldoc = Nokogiri::XML(File.open(f))
        @r.sadd "NEWS_XML", "#{xmldoc}"
      end
    end
  end
  
end
