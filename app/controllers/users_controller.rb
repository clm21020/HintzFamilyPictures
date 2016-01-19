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

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update(username: user_params[:username], email: user_params[:email])
			redirect_to @user
		else
			render 'edit'
		end
	end

	def edit_password
		@user = User.find(params[:id])
	end

	def update_password
		@user = User.find(params[:id])

		if @user.valid_password?(update_password_params[:old_password]) && 
				@user.update(password: update_password_params[:new_password])
			redirect_to @user
		else
			render 'edit_password'
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def update_password_params
		params.require(:user).permit(:old_password, :new_password)
	end
end