ruby = "ruby1.9" # must be 1.9
erb = "erb1.9"   # must be 1.9
autoload :FileUtils, 'fileutils'

targets = %w[ ruby-committers/ruby-committers.html ruby-committers/ruby-committers.opml ruby-committers/ruby-committers.foaf ]

task :default => :generate
task :generate => targets
task :archive => :generate do
  sh "tar czf ruby-committers.tar.gz ruby-committers"
end
task :clean do
  FileUtils.rm_f targets
  FileUtils.rm_f 'ruby-committers.tar.gz'
end

rule 'ruby-committers/ruby-committers.html' => %w[ ruby-committers.html.erb ruby-committers.yml config.yml ] do |t|
  sh "#{erb} -T- #{t.source} > #{t.name}"
end

rule 'ruby-committers/ruby-committers.opml' => %w[ opml-generator.rb ruby-committers.yml ] do |t|
  sh "#{ruby} #{t.source} > #{t.name}"
end

rule 'ruby-committers/ruby-committers.foaf' => %w[ rdf-generator.rb ruby-committers.yml ] do |t|
  sh "#{ruby} #{t.source} > #{t.name}"
end
