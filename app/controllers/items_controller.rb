class ItemsController < ApplicationController
	before_action :ensure_logged_in, only: [:new, :create, :edit, :update, :destroy]
	before_action :ensure_admin, only: [:new, :create, :edit, :update, :destroy]

	def index
		if current_user && params[:cu_interest_level] == "interested"
			@items = current_user.interests.includes(:keywords, :pictures)
			@title = "My Interests"
		else
			@items = Item.includes(:keywords, :pictures)
			@title = "All Items"
		end
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(title: item_params[:title])

		if @item.save
			@item.update(keywords: prepped_keywords)
			@item.update(pictures: prepped_pictures)
			redirect_to @item
		else
			render 'new'
		end
	end

	def show
		@item = Item.find(params[:id])
	end

	def rank
		new_interest_level = params[:ranking]
		item = Item.find(params[:id])
		ranking = Ranking.where(user_id: current_user.id, item_id: item.id).first || 
							Ranking.new(user_id: current_user.id, item_id: item.id)

		ranking.interest_level = new_interest_level

		respond_to do |format|
			if new_interest_level == "0"
				ranking.destroy
				format.json { render json: new_interest_level, status: :ok }
			elsif ranking.save
	      format.json { render json: new_interest_level, status: :ok }
	    else
	    	format.json { render status: :bad_request}
	    end
	  end
	end

	# NEEDS A VIEW
	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])

		# THIS DOESN'T WORK FOR KEYWORDS
		# if @item.update_attributes(item_params)
		# 	redirect_to @item
		# else
			render 'edit'
		# end
	end

	def destroy
	end

	private
		def item_params
			@item_params ||= params.require(:item).permit(:title, :keywords, images: [])
		end

		def prepped_keywords
			keywords = item_params[:keywords].split(",").map(&:strip).uniq
			
			keywords.map! do |kw|
				Keyword.new(word: kw)
			end

			keywords
		end

		def prepped_pictures
			pictures = item_params[:images]
			return [] if pictures.nil?

			pictures.map! do |image|
				Picture.new(image: image)
			end
			
			pictures
		end

		def ensure_admin
			redirect_to items_url unless current_user.admin?
		end
end