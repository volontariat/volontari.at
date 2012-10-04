class ProductsController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  respond_to :html, :js, :json
  
  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    
    if @product.save
      redirect_to @product, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    
    if @product.update_attributes(params[:product])
      redirect_to @product, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @product
  end
  
  private
  
  def not_found
    redirect_to products_path, notice: t('products.exceptions.not_found')
  end
end