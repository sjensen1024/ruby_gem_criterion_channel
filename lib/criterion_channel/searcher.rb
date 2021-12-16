class CriterionChannel::Searcher
	attr_reader :connector
	
	def initialize()
		@connector = Mechanize.new
	end

	def search(search_term, number_of_results = 5)
		results = []
		@connector.get(generate_search_url(search_term)) do |page|
			sleep(0.5)
			for i in 1 .. number_of_results
				result_xpath = '//*[@id="search-results"]/div[2]/div/div/div[2]/ul/li[SEARCH_INDEX]/div/div/a'.gsub('SEARCH_INDEX', i.to_s)
				get_at_xpath = page.parser.xpath(result_xpath)
				break if get_at_xpath.nil? || get_at_xpath.first.nil? || get_at_xpath.first.attributes.nil?
				result_attributes = get_at_xpath.first.attributes
				break if result_attributes["data-track-event-properties"].nil? || result_attributes["data-track-event-properties"].value.blank?
				result_json = JSON.parse(result_attributes["data-track-event-properties"].value)
				results.push(result_json["label"]) if result_json["label"].present?
			end
		end
		results
	end

	def search_first_result(search_term)
		results = search(search_term, 1)
		results.any? ? results.first : nil
	end

	private

	def generate_search_url(search_term)
		url = 'https://www.criterionchannel.com/search'
		url += '?q=' + sanitize_search_term(search_term) if search_term.present?
		url
	end

	def sanitize_search_term(search_term)
		CGI.escapeHTML(search_term)
	end

end