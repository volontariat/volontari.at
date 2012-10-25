class Workflow::ProductsController < ApplicationController
  def show
    @stories = Product.stories(params[:id], current_user, params[:page])
    @product = Product.find(params[:id]) unless params[:id] == 'no-name'
  end
end