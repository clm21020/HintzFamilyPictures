class UsersController < ApplicationController
	before_action :ensure_logged_in, except: :create
	before_action :ensure_authorized, except: :create

	def create
		@user = User.new(user_params)

		if @user.save
			log_in!(@user)
			redirect_to items_url
		else
			flash.now[:signup_errors] = @user.errors.full_messages
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
			flash.now[:update_errors] = @user.errors.full_messages
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
			flash.now[:update_password_errors] = update_password_errors
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

	def ensure_authorized
		redirect_to	items_url unless params[:id] == current_user.id.to_s || current_user.admin?
	end

	def update_password_errors
		errors = []
		
		errors << "Old Password can't be blank" if update_password_params[:old_password].blank?
		errors << "New Password can't be blank" if update_password_params[:new_password].blank?
		return errors unless errors.empty?
		
		if @user.errors.messages[:password]
			errors = @user.errors.messages[:password].map { |message| "New password #{message}" }
		else
			errors << "Old password is incorrect"
		end

		errors
	end
end