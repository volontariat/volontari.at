# This migration comes from voluntary_scholarship_engine (originally 20140306201232)
class AddScholarshipProduct < ActiveRecord::Migration
  def up
    begin
      Product.create(name: 'Scholarship', text: 'Dummy')
    rescue
    end
  end
  
  def down
    Product.find_by_name('Scholarship').destroy
  end
end
