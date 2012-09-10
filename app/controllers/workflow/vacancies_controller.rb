class Workflow::VacanciesController < ApplicationController
  def open
    @vacancies = Vacancy.where(state: 'open')
  end
  
  def recommended
    @vacancies = Vacancy.where(state: 'recommended') 
  end
  
  def denied
    @vacancies = Vacancy.where(state: 'denied')
  end
  
  def closed
    @vacancies = Vacancy.where(state: 'closed')
  end
end