require "zip"
require 'nokogiri'
require 'open-uri'
require 'redis'
NEWS_XML = Redis.new

@urls = []
@uri = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"
@target = "/" + @uri.split("//")[1]
@dir = Dir["temp/#{@target}*.zip"]

page = Nokogiri::HTML(open(@uri))

page.xpath('//a/@href').each do |links|
  @urls << links.content
end

@urls.each do |url|
  `wget -r -nc -np -l 1 -A zip -P "./temp" "#{@uri}#{url}"`
end

@dir.each do |d|
  Zip::File.open(d) do |zip_file|
    zip_file.each do |f|
      f.extract("data/#{f}")
    end
  end
end

Dir["data/*.xml"].each do |f|
  xmldoc = Nokogiri::XML(File.open(f))
  NEWS_XML.set(f, xmldoc)
end

Dir["data/*.xml"].each do |f|
  puts NEWS_XML.get("#{f}")
end
