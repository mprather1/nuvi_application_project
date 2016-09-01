Tested on Xubuntu 15.10.
Ruby 2.3.0
Requires Ruby Gems listed below:
  "zip"
  "nokogiri"
  "open-uri"
  "redis"

Downloads files linked to in <a> tags on url specified in Scraper.target to ./temp.
Extracts zip files from ./temp  to ./data
Imports contents of xml files in ./data to Redis list entitled 'NEWS_XML'.

Directions:

Open terminal in directory and type "ruby run.rb"

or 

require_relative 'app'

app = Scraper.new

app.target("http://example") # this is the url with the zip files to download.

# the following folders must exist in the directory before script is ran.
app.folder('temp') #this is the temp folder that will contain the zip folders.
app.data('data') # this is the folder that will contain the extracted xml files.

app.download_files # downloads the files to folder specified in app.folder.
app.extract_zip_files # extracts zip files to folder specified in app.data.
app.to_redis # uploads contents of files in folder specified in app.data to Redis list.
