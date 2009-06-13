begin
  require 'rubygems'
  gem 'amazon-ecs'
rescue LoadError
  # nothing to do
end
require 'amazon/ecs'
require 'isbn' # http://github.com/k16shikano/isbn.rb

def configure_ecs(key) 
  Amazon::Ecs.configure do |config|
    config[:aWS_access_key_id] = [ key ]
    config[:country] = :jp
  end
end

def fetch_image(isbn)
  isbn = ISBN.new(isbn)
  asin = isbn.isbn10
  $stderr.puts "searching #{asin}"
  item = Amazon::Ecs.item_lookup(asin, :response_group => 'Medium').first_item
  sleep 1
  return if item.nil?
  return unless item.get('smallimage')

  return item.get('itemattributes/title').force_encoding("UTF-8"), item.get('smallimage/url').force_encoding("UTF-8")
end
