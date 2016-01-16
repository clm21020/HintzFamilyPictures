class SessionsController < ApplicationController
	def create
		@user = User.find_by_credentials(session_params[:identification], session_params[:password])

		if @user
			log_in!(@user)
			redirect_to items_url
		else
			render "static_pages/welcome"
		end
	end

	def destroy
		log_out!
		redirect_to welcome_url
	end

	private
	def session_params
		params.require(:session).permit(:identification, :password)
	end
end