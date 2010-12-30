= The List of Ruby Committers
The Ruby community is sometimes a bit too high-contextual. Who is "mput"? Who is "zenspider"? What does "why is why why" mean? What does it mean when ko1 says "the patch monster does ....".?

The list shows you who's who.

Many contributions made Ruby what now Ruby is. The honor of contribution for Ruby is not only the committers's. But it is sure that the committers are worth people to follow their activities. Follow them on twitter. Subscribe their blogs.

== How to use
ruby-committers.yml is written in YAML. You can use it with any YAML processor.

You can generate OPML, FOAF and HTML version of the list with the bundled generators.
(1) write config.yml like:
     aws-key: <Your Amazon Webservice Key here>
     secret-key: <Your secret key here>
(2) install Ruby 1.9.2 or later
(3) install bundler
     gem install bundler
(4) install gems like:
     bundle install --path .bundle/gems
(5) run generators:
     bundle exec rake

== Copyright and License
=== ruby-committers.yml 
This list was originally written by Yugui (Yuki Sonoda).  It is a list of facts so none has the copyright for it. It is in the public domain.

=== Generators
* Gemfile
* Rakefile
* opml-generator.rb
* rdf-generator.rb
* ruby-committers.html.erb
The generators were originally developed by Yugui (Yuki Sonoda) on 2009-2010.

They are distributed under Creative Commons Attribution 3.0 Unported License.
* http://creativecommons.org/licenses/by/3.0/

=== External resources
Most of resources referenced by the list have their own copyright holder.
