#!/usr/bin/ruby
require 'rss'

def foldername(title)
  if title.include?("(revised)")
    "Railscasts Revised"
  elsif title.include?("(pro)")
    "Railscasts Pro"
  else
    "Railscasts"
  end
end

if File.exist?("rss.index")
  p 'Read rss index'
  rss_string = ''
  File.open('rss.index', 'r') do |file|
    while line = file.gets
      rss_string += line
    end
  end
else
  p 'Downloading rss index'
  rss_string = open('http://feeds.feedburner.com/railscasts').read
  File.open('rss.index', 'w') {|file| file.puts rss_string }
end


p 'Parsing rss index'
rss = RSS::Parser.parse(rss_string, false)

videos_urls = rss.items.map { |it| {:folder =>foldername(it.title), :url =>it.enclosure.url}}.reverse

videos_filenames = videos_urls.map {|k| k[:url].split('/').last }
existing_filenames = Dir.glob('**/*.mp4')
missing_filenames = videos_filenames - existing_filenames
p "Downloading #{missing_filenames.size} missing videos"

missing_videos_urls = videos_urls.select { |video_url| missing_filenames.any? { |filename| video_url[:url].match filename } }

missing_videos_urls.each do |video_url|
  filename = File.join(video_url[:folder], video_url[:url].split('/').last)
  p filename
  p %x(wget -c #{video_url[:url]} -O #{filename}.tmp )
  p %x(mv #{filename}.tmp #{filename} )
end
p 'Finished synchronization'

