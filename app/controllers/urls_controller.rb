class UrlsController < ApplicationController

	before_action :find_url, only: [:show]
	http_basic_authenticate_with name: "admin", password: "admin", only: [:stats]


	def index
		@url = Url.new
	end

	def show
		@url.statistic.increment!(:url_opened, 1)
		@url.statistic.update(last_opened_at: Time.now)
		@url.statistic.update(last_browser_opened_on: "#{@browser} #{@version.to_s}")
		redirect_to @url.format_url
	end

	def create
		@url = Url.new(url_params)
		@url.format_url
		if @url.new_url?
			if @url.save
      			respond_to do |format|
      				format.js()
      			end
      		else
        			flash[:error] = "Check the error below:"
        			render 'index'
      		end
		else
			@url = Url.find_by(formatted_url: @url.formatted_url)
			@url.statistic.increment!(:same_url_converted, 1)
			respond_to do |format|
				format.js()
			end
		end
	end

	def stats
		@url_stats = []
		urls = Url.joins(:statistic).select(:original_url, :converted_url, :created_at, :url_opened, :same_url_converted, :last_opened_at, :last_browser_opened_on)
		if urls.present? && urls.size > 0
			urls.each do |url|
				@url_stats << url
			end
		end
		respond_to do |format|
			format.html()
		end
	end

	private

	def find_url
		@url = Url.find_by(converted_url: params[:converted_url])
	end

	def url_params
    		params.require(:url).permit(:original_url)
  	end
end
