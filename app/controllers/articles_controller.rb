class ArticlesController < ApplicationController
  include SessionHelper
  before_action :should_login, except: [:show, :index]

  def new
    @article ||= Article.new
  end

  def create
    @article = Article.new(article_params)
    uploaded_io = params[:article][:file]
    unless uploaded_io.nil?
      @article.content = uploaded_io.read
    end
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
    @article.title = params[:article][:title]
    @article.author = params[:article][:author]
    if (uploaded_io = params[:article][:file])
      @article.content = uploaded_io.read
    else
      @article.content = params[:article][:content]
    end
    (redirect_to @article and return) if @article.save    
    render 'edit'
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_url
  end

  def confirm
  end

  private
    def article_params
      params.require(:article).permit(:title, :author, :content)
    end
end
