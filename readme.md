A simple railscasts downloader
=========================================

## How to use ?

git clone the project to somewhere , eg. ~/railscasts-donwloader


cd ~/railscasts-downloader and download rss file . 

    wget http://feeds.feedburner.com/railscasts -O rss.index

if you are a subscribed user, login to your account , download your subscription rss link

    wget your-subscription-rss-link -O rss.index


start to download

    ruby railscasts-downloader.rb

then the casts in your will be downloaded and organized by type(railscast, pro , revised)