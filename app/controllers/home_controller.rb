class HomeController < ApplicationController
  def index
    @projects = Project.limit(5).order('created_at DESC').all
    @vacancies = Vacancy.limit(5).order('created_at DESC').all
  end
end