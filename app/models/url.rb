class Url < ActiveRecord::Base
	validates :original_url, presence: true, on: :create
	before_create :get_short_url

	def get_short_url
		charset = ['0'..'9','A'..'Z','a'..'z'].collect{|char| char.to_a}.flatten
	    	self.converted_url = 6.times.map{charset[rand(charset.size)]}.join
	end

	def format_url
	    self.original_url.strip!
	    self.protocol = self.original_url.include?("https:") ? "https" : "http"
	    self.formatted_url = self.original_url.gsub(/https{1}?\D{3}?w{3}?\W?/, "")
	    self.formatted_url = "#{self.protocol}://#{self.formatted_url}"
	end
end
