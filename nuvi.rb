require 'nokogiri'
require 'open-uri'
require 'net/http'

@urls = []
@uri = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"
@target = "/" + @uri.split("//")[1]
@dir = Dir["temp/#{@target}*.zip"]

def unzip(arg)
  `unzip "#{arg}" -d data`
end

page = Nokogiri::HTML(open(@uri))

page.xpath('//a/@href').each do |links|
  @urls << links.content
end

@urls.each do |url|
  `wget -r -nc -np -l 1 -A zip -P "./temp" "#{@uri}#{url}"`
end

@dir.each do |f|
  unzip(f)
end


# @urls.each do |url|
#   open("#{url}", 'wb') do |fo|
#   fo.print open("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/#{url}").read
# end
# end

# @urls.each do |url|
#   open(url, 'wb') do |f|
#     f.print open("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/#{url}").read
#   end
# end


# open("1472263084392.zip", 'wb') do |fo|
#   fo.print open("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/1472263084392.zip").read
# end
# @urls.each do |url|
  # `wget "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/#{url}"`
#   File.open("#{url}", 'wb') do |fo|
#     puts "#{url}"# fo.write open("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/").read
#   end
#     # open("/files", "wb") do |file|
#     #   file.write(resp.body)
#     # end
#   # end
# end
# puts @urls
# Net::HTTP.start('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/') { |http|
#   @urls.length.times do |i|
    
# }
# end

# @urls.length.times do |i|
  # Net::HTTP.start(i) do |http|
  #   resp = http.get("/.zip")
  #   open("/files", "wb") do |file|
  #     file.write(resp.body)
  #   end
  # end
# end