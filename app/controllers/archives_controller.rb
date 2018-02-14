class ArchivesController < ApplicationController

	def index
		@articles_by_month = Article.all.group_by { |article| article.created_at.strftime("%B") } 
	end

end