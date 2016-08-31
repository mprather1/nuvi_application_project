require "zip"
require 'nokogiri'
require 'open-uri'
require 'redis'
r = Redis.new
redis.del 'NEWS_XML'

@urls = []
@target = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"
@dir = Dir["temp/" + @target.split("//")[1] + "*.zip"]

page = Nokogiri::HTML(open(@target))

page.xpath('//a/@href').each do |links|
  @urls << links.content
end

@urls.each do |url|
  `wget -r -nc -np -l 1 -A zip -P "./temp" "#{@target}#{url}"`
end

@dir.each do |d|
  Zip::File.open(d) do |zip_file|
    zip_file.each do |f|
      f.extract("data/#{f}") { true }
    end
  end
end

Dir["data/*.xml"].each do |f|
  xmldoc = Nokogiri::XML(File.open(f))
  r.sadd(xmldoc)
end

# Dir["data/*.xml"].each do |f|
  # puts NEWS_XML.get("#{f}")
# end

# r.smembers('NEWS_XML')
