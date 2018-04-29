class Url < ActiveRecord::Base
	validates :original_url, presence: true, on: :create
	validates_format_of :original_url, :with => /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
	before_create :get_short_url
	after_create :create_statistic

	has_one :statistic, dependent: :destroy, class_name: 'UrlStatistic'

	def get_short_url
		charset = ['0'..'9','A'..'Z','a'..'z'].collect{|char| char.to_a}.flatten
	    	self.converted_url = 6.times.map{charset[rand(charset.size)]}.join
	    	url = Url.find_by(converted_url: self.converted_url)
	    	unless url.nil?
	    		self.converted_url = 6.times.map{charset[rand(charset.size)]}.join
	    	end
	end

	def format_url
	    self.original_url.strip!
	    self.protocol = self.original_url.include?("https:") ? "https" : "http"
	    self.formatted_url = self.original_url.gsub(/https{1}?\D{3}?w{3}?\W?/, "")
	    self.formatted_url = "#{self.protocol}://#{self.formatted_url}"
	end

	def new_url?
		Url.find_by(formatted_url: self.formatted_url).blank?
	end

	def create_statistic
		UrlStatistic.create(url_id: self.id)
	end
end
