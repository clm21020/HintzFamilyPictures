class UsersController < ApplicationController
	def create
		@user = User.new(user_params)

		if @user.save
			redirect_to items_url
		else
			render "static_pages/welcome"
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end
end