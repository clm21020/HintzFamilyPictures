class ItemsController < ApplicationController
	def index
		@items = Item.all
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
end