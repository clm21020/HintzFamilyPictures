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
			@item.update(key_words: prepped_key_words)
			# maybe update this later to ask to add pictures ???
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
			@item_params ||= params.require(:item).permit(:title, :key_words)
		end

		def prepped_key_words
			key_words = item_params[:key_words].split(",").map(&:strip).uniq
			
			key_words.map! do |kw|
				KeyWord.new(word: kw)
			end

			key_words
		end
end