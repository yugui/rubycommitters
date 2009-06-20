# -*- coding: UTF-8 -*-
require 'yaml'
require 'nokogiri'
require 'net/http'
require 'uri'

def feed_type(url)
  uri = nil
  loop do
    $stderr.puts "checking #{url}"
    uri = URI.parse(url)
    begin
      res = Net::HTTP.start(uri.host, uri.port || 80) {|conn| conn.head(uri.request_uri) }
    rescue
      warn $!.message + "\n" + $!.backtrace.join("\n")
      break
    end

    if res.code =~ /^3\d\d$/
      raise res.to_s unless res['location']
      url = res['location'] 
      next
    end

    case res['content-type'][/[^;]+/]
    when 'text/rss', 'text/rss+xml', 'application/rss+xml', 'application/rdf+xml', 'application/xml', 'text/xml'
      return 'rss'
    when 'text/atom', 'text/atom+xml', 'application/atom+xml'
      return 'atom'
    else
      break
    end
  end

  case File.extname(uri.path)
  when '.rdf', '.rss'
    return 'rss'
  when '.atom'
    return 'atom'
  end
  case File.basename(uri.path)
  when 'rss.xml', 'rdf.xml'
    return 'rss'
  when 'atom.xml'
    return 'atom'
  else
    raise "Unsuitable mime type #{res['content-type']}"
  end
end

committers = YAML.load_file('ruby-committers.yml')

opml = Nokogiri::XML::Builder.new {
  opml(:version => '2.0') {
    head {
      title        'The Subscription to Ruby Committers'
      dateCreated  Time.local(2009, 5, 18, 20, 45).to_s
      dateModified Time.now.to_s
      ownerName    'Yugui (Yuki Sonoda)'
      ownerEmail   'yugui@yugui.jp'
    }
    body {
      committers.each do |attrs|
        (attrs['sites'] || []).each do |site|
          next unless site['feed']
          outline :text => site['title'],
            :title => site['title'], 
            :description => "by #{attrs['account']} - #{(attrs['name'] || attrs['nick']).first}", 
            :htmlUrl => site['url'], 
            :xmlUrl => site['feed'],
            :type => (site['feedtype'] || feed_type(site['feed'])),
            :language => (site['lang'] || 'unknown')
        end
      end
    }
  }
}
puts opml.to_xml
# vim: set fileencoding=utf-8
