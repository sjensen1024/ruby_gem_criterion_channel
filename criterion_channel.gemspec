Gem::Specification.new do |s|
  s.name        = 'criterion_channel'
  s.license		  = "MIT"
  s.version     = '0.2.0'
  s.date        = '2021-12-15'
  s.summary		  = "This gem gets information about movies available on the Criterion Channel."
  s.description = "This gem parses the current HTML of the Criterion Channel's film list page and
                    returns the data in a more Ruby-esque fashion. Because of the current lack of
                    an API and the current status of parsing the current HTML, please be aware that
                    if the Criterion Channel's HTML or design changes, this gem may stop working."
  s.authors     = ["Steve Jensen"]
  s.email       = 'stevenmjensen1024@gmail.com'
  s.files       = Dir.glob(["lib/*", "lib/criterion_channel/*"])
  s.homepage	  = "https://github.com/sjensen1024/ruby_gem_criterion_channel"
  s.add_dependency "httparty", "~> 0.18", ">= 0.18.0"
  s.add_dependency "activesupport", "~> 6.1", ">= 6.1.0"
  s.add_dependency "nokogiri", "~> 1.10", ">= 1.10.9"
  s.add_dependency "cgi", "~> 0.3", ">= 0.3.1"
  s.add_dependency "mechanize", "~> 2.8", ">= 2.8.1"
end