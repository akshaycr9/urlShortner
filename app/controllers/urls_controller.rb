class UrlsController < ApplicationController

	before_action :find_url, only: [:show]

	def index
		@url = Url.new
	end

	def show
		redirect_to @url.format_url
	end

	def create
		@url = Url.new(url_params)
		@url.format_url
      	if @url.save
      		respond_to do |format|
      			format.js()
      		end
      	else
        		flash[:error] = "Check the error below:"
        		render 'index'
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
