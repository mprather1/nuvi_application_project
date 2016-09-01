require_relative 'application_project'

app = Scraper.new
app.target = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"
app.download_files
app.extract_zip_files
app.import_to_redis
