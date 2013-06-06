class HomeController < ApplicationController
  def index
    @projects = Project.limit(5).order('created_at DESC').all
    @vacancies = Vacancy.open.limit(5).order('created_at DESC').all
    @page = Page.where(name: 'Home').first
  end
end