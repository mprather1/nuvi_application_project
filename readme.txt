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

New url can be added as per instructions below.

Directions:

Open terminal in directory and type "ruby run.rb"

or 

require_relative 'app'

app = Scraper.new

app.target("http://example")    # url format => "http://example.org/whatever/"
app.create_folders    # creates data and download folders in bin folder
app.download_files    # downloads the files to bin/folder.download
app.extract_zip_files     # extracts zip files to bin/folder.data
app.to_redis    # uploads contents of files in bin/folder.data to Redis list.
