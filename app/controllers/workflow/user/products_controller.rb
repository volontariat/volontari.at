class Workflow::User::ProductsController < ApplicationController
  def show
    if params[:id] == 'no-name'
      @stories = Story.exists(_type: false)
    else
      @product = Product.find(params[:id])
      
      begin
        @stories = @product.story_class.for_user(current_user)
      rescue NotImplementedError
        @stories = @product.story_class
      end
    end
    
    @stories = @stories#.page(params[:page]).per(1)
  end
end