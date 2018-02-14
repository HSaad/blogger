class PopularArticlesController < ApplicationController

	def index 
		@popular_articles = Article.order('articles.view_count DESC').limit(3)
	end

end
