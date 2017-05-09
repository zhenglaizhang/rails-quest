class ArticlesController < ApplicationController
  # only public methods can be actions for controllers
  def new

  end

  #  Rails by default returns 204 No Content response for an action if we don't specify what the response should be
  def create
    render plain: params[:article].inspect
  end
end
