require_relative 'app'

app = Scraper.new
app.target = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"
app.download_files
app.extract_zip_files
app.to_redis
