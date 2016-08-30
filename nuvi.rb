require 'nokogiri'
require 'open-uri'
require 'net/http'

@urls = []

page = Nokogiri::HTML(open('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/'))

page.xpath('//a/@href').each do |links|
  @urls << links.content
end

@urls.each do |url|
  `wget -r -nc -np -l 1 -A zip -P "./temp" "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/#{url}" `
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