class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def article_params
      params.require(:article).permit(:title, :author, :content)
    end
end
