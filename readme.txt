Tested on Xubuntu 15.10.
Requires Ruby Gems listed below:
  "zip"
  "nokogiri"
  "open-uri"
  "redis"

Downloads files linked to in <a> tags on url specified in Scraper.target to ./temp.
Extracts zip files from ./temp  to ./data
Imports contents of xml files in ./data to Redis.

Directions:
Open terminal in directory and type "ruby run.rb"


