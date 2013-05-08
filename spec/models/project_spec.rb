require 'spec_helper'

class Product::NewProduct < Product; ; end

describe Project do
  describe 'callbacks' do
    describe '#include_areas_of_product' do
      it 'includes areas of product before validation' do     
        subject = Factory.build(:project)
        subject.product_id = FactoryGirl.create(:product, name: 'New Product', area_ids: [FactoryGirl.create(:area, name: 'Area2').id]).id
        area_ids_before = subject.area_ids
        subject.save!
        subject.area_ids.should == area_ids_before + subject.product.area_ids
      end
    end
  end
end