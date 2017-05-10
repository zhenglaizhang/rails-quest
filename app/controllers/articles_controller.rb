class ArticlesController < ApplicationController
  # only public methods can be actions for controllers
  def new

  end

  #  Rails by default returns 204 No Content response for an action if we don't specify what the response should be
  def create
    # render plain: params[:article].inspect

    # every Rails model can be initialized with its respective attributes, which are automatically mapped to the respective database columns.
    @article = Article.new(params.require(:article).permit(:title, :text))
    @article.save
    redirect_to @article
  end
end
