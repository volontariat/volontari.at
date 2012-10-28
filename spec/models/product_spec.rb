require 'spec_helper'

class Product::MyProduct; ; end

describe Product do
  describe 'validations' do
    describe 'english_name_available?' do
      it 'assures that a english name is present' do
        I18n.locale = :de
        subject = Factory.build(:product, name: 'Product')
        subject.valid?
        
        subject.errors[:name].include?(
           I18n.t(
             'activerecord.errors.models.product.attributes.name.missing_english_name'
           )
        ).should == true
        
        I18n.locale = I18n.default_locale
        subject = Factory.build(:product, name: 'Product')
        subject.valid?
        
        subject.errors[:name].include?(
           I18n.t(
             'activerecord.errors.models.product.attributes.name.missing_english_name'
           )
        ).should == false
      end
    end
    
    describe 'existing_model_file?' do
      it 'assures that a model file exists' do
        subject = Factory.build(:product, name: 'Unavailable')
        subject.valid?
     
        subject.errors[:name].include?(
          I18n.t(
            'activerecord.errors.models.product.attributes.name.missing_model_file'
          )
        ).should == true
        
        subject = Factory.build(:product, name: 'My Product')
        subject.valid?.should == true
      
        subject.errors[:name].include?(
          I18n.t(
            'activerecord.errors.models.product.attributes.name.missing_model_file'
          )
        ).should == false
      end
    end
  end
end
