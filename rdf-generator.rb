# -*- coding: UTF-8 -*-
require 'yaml'
require 'isbn'
require 'builder'
require 'builder/xmlmarkup'

committers = YAML.load_file('ruby-committers.yml')


xml = Builder::XmlMarkup.new
xml.instruct!
xml.rdf:RDF,
 :'xmlns:rdf' => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
 :'xmlns:foaf' => "http://xmlns.com/foaf/0.1/" do
  committers.each do |attrs|
    xml.foaf:Person, :'rdf:about' => "urn:ruby-committer:#{attrs['account']}" do
      (attrs['name'] || []).each do |name|
        xml.foaf:name, name
      end
      (attrs['nick'] || []).each do |nick|
        xml.foaf:nick, nick
      end
      (attrs['portraits'] || []).each do |url|
        xml.foaf:depiction, :'rdf:resource' => url
      end
      (attrs['sites'] || []).each do |site|
        if site['feed']
          xml.foaf:weblog, :'rdf:resource' => site['url']
        else
          xml.foaf:homepage, :'rdf:resource' => site['url']
        end
      end
      [
        ['twitter', 'http://twitter.com'],
        ['friendfeed', 'http://friendfeed.com'],
        ['github', 'http://github.com'],
        ['facebook', 'http://facebook.com'],
        ['mixi', 'http://mixi.jp'],
      ].each do |service, url|
        if attrs['services'] and attrs['services'][service]
          xml.foaf:holdsAccount do
            xml.foaf:OnlineAccount do
              xml.foaf:accountName, attrs['services'][service]
              xml.foaf:accountServiceHomepage, :'rdf:resource' => url
            end
          end
        end
      end
      (attrs['ruby-books'] || []).each do |isbn|
        xml.foaf:made, :'rdf:resource' => "uri:isbn:#{isbn}"
      end
    end
  end
end
puts xml.target!
# vim: set fileencoding=utf-8
