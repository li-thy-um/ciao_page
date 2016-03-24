class ArticlesController < ApplicationController
  include SessionHelper
  before_action :should_login, except: [:show, :index]

  def new
    @article ||= Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article and return
    end
    render new
  end

  def index
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @articles = @tag && @tag.articles.all
    end
    @articles ||= Article.all
    @tags = Tag.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article and return
    end
    render 'edit'
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_url
  end

  private
    def article_params
      params.require(:article).permit(:title, :author, :content)
    end
end
