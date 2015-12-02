class SessionsController < ApplicationController
	def create
		@user = User.find_by_credentials(session_params[:identification], session_params[:password])

		if @user
			redirect_to @user
		else
			render "static_pages/welcome"
		end
	end

	private
	def session_params
		params.require(:session).permit(:identification, :password)
	end
end