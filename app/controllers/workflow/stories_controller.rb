class Workflow::StoriesController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @stories = @product.stories
  end
end