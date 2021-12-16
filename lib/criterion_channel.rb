class CriterionChannel
	require "httparty"
	require "nokogiri"
	require "mechanize"
	require "cgi"
	require "active_support/all"
	require "criterion_channel/film"
	require "criterion_channel/searcher"

	attr_reader :films, :data_pull_time, :searcher

	CRITERION_CHANNEL_DATA_URL = "https://films.criterionchannel.com/channel/films"
	TABLE_DATA_TYPES = { country: "criterion-channel__td criterion-channel__td--country",
		director: "criterion-channel__td criterion-channel__td--director",
		img: "criterion-channel__td criterion-channel__td--img",
		title: "criterion-channel__td criterion-channel__td--title",
		year: "criterion-channel__td criterion-channel__td--year" }

	def initialize
		@films = parse_films_from_data
		@data_pull_time = Time.now
		@searcher = CriterionChannel::Searcher.new
	end

	private

	def get_raw_table_data_from_rows(table_rows)
		table_rows.map{ |i| i.children.select{ |j| 
			j.name.present? && j.name.downcase == "td" } 
		}
	end

	def get_raw_table_rows_from_url
		site_response = HTTParty.get(CRITERION_CHANNEL_DATA_URL)
		site_response_body_html = Nokogiri::HTML.parse(site_response.body)
		raw_table_rows = site_response_body_html.xpath("//tr").select{ |i| i.children.present? }
		raw_table_rows
	end

	def parse_films_from_data
		films = []
		table_rows = get_raw_table_rows_from_url
		table_rows.each do |row|
			row_data = row.children.select{|td| td.name.present? && td.name.downcase == "td"}
			if ( row_data.select{ |data| data.attributes["class"].value.present? && 
				data.children.present? && data.children.any? } ).any?
				film_params = set_film_params_from_row_data(row_data)
				films.push( CriterionChannel::Film.new(film_params) )
			end
		end
		films
	end

	def set_film_params_from_row_data(row_data)
		film_params = {}
		row_data.each do |data| 
			data_type = data.attributes["class"].value.downcase
			if data_type == TABLE_DATA_TYPES[:img]
				film_params[:img] = Nokogiri::HTML.parse(data.children.to_s.squish).xpath(
					"//img").first.attributes["src"].to_s
			elsif data_type == TABLE_DATA_TYPES[:title]
				film_params[:title] = data.children.text.to_s.squish
			elsif data_type == TABLE_DATA_TYPES[:director]
				film_params[:director] = data.children.to_s.squish
			elsif data_type == TABLE_DATA_TYPES[:country]
				film_params[:country] = data.children.text.to_s.squish.gsub(",","")
			elsif data_type == TABLE_DATA_TYPES[:year]
				film_params[:year] = data.children.to_s.squish
			end
		end
		film_params
	end

end