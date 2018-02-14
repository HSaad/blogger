class ArticlesController < ApplicationController
	include ArticlesHelper
	before_action :require_login, except: [:index, :show, :destroy]

	def index 
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
		@article.increment
		@comment = Comment.new
		@comment.article_id = @article.id
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.save
		
		flash.notice = "Article '#{@article.title}' Created!"

		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		flash.notice = "Article '#{@article.title}' Deleted!"

		redirect_to articles_path
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		@article.update(article_params)

		flash.notice = "Article '#{@article.title}' Updated!"

		redirect_to article_path(@article)
	end

	def feed
  	@title = "RSS Feed"

  	@articles = Article.order("updated_at desc")

  	# this will be our Feed's update timestamp
  	@updated = @articles.first.updated_at unless @articles.empty?

  	respond_to do |format|
    	format.atom { render :layout => false }

    # we want the RSS feed to redirect permanently to the ATOM feed
    	format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
 		end
	end

end
