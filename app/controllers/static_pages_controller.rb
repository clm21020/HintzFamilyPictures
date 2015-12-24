class StaticPagesController < ApplicationController
	before_action :already_logged_in

	def welcome
	end

	def already_logged_in
    redirect_to items_url if logged_in?
  end
end