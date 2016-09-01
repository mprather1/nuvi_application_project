require_relative 'app'
require 'io/console'

app = Scraper.new
app.target = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"
app.download_files
app.extract_zip_files
app.to_redis

puts "All done..."
print "Press any key to exit..."
STDIN.getch
print "\n"