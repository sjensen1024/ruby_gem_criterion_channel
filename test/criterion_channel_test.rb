require 'criterion_channel'
require "active_support"
require "active_support/core_ext/object"

test_instance = CriterionChannel.new

puts test_instance.inspect

puts "\nTEST INSTANCE DATA PULL TIME: " + test_instance.data_pull_time.to_s

ordered_titles = test_instance.films.map{|i| i.title}.sort{ |x,y| x <=> y }
puts "\nTEST INSTANCE GET ALL TITLES ORDERED ALPHABETICALLY:"
ordered_titles.each do |title|
	puts title
end


puts "\nTEST INSTANCE GET TITLES OF ALL FILMS MADE IN 1963: "
movies_made_in_1963 = test_instance.films.select{ |i| i.year == "1963" }.map{ |i| i.title }
movies_made_in_1963.each do |title|
	puts title
end

puts "\nTEST INSTANCE GET ORDERED LIST OF DISTINCT DIRECTORS: "
distinct_directors = test_instance.films.map{ |i| i.director }.uniq.sort{ |x,y| x <=> y }
distinct_directors.each do |director|
	puts director
end

puts "\nGET ALL INFORMATION FOR ALL OF THE FILMS BY WIM WENDERS: "
films_by_wim_wenders = test_instance.films.select{ |i| i.director.upcase == "WIM WENDERS" }
films_by_wim_wenders.each do |film|
	puts "\n"
	puts "TITLE: #{film.title}"
	puts "YEAR: #{film.year}"
	puts "DIRECTOR: #{film.director}"
	puts "COUNTRY: #{film.country}"
	puts "IMG: #{film.img}"
	puts "\n"
end

puts "\nGET DISTINCT COUNTRIES WITH FILMS IN THE LIST: "
countries = test_instance.films.map{ |i| i.country }.uniq.sort{ |x,y| x <=> y }
countries.each do |country|
	puts country
end