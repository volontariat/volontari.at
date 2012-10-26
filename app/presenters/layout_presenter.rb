class LayoutPresenter < ResourcePresenter
  def table_presenter(new_subject)
    @table_presenter = Shared::Collection::TablePresenter.new(new_subject) 
  end
  
  def table_presenter=(presenter)
    @table_presenter = presenter 
  end
end