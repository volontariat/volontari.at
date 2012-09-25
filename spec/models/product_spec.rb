require 'spec_helper'

describe Product do
  describe 'validations' do
    describe 'english_name_available?' do
      it 'assures that a english name is present' do
        I18n.locale = :de
        subject = Factory.build(:product, name: 'Text Creation')
        subject.valid?
        subject.errors.messages[:name].length.should == 1
        I18n.locale = I18n.default_locale
        subject = Factory.build(:product, name: 'Text Creation')
        subject.valid?.should == true
      end
    end
    
    describe 'existing_model_file?' do
      it 'assures that a english name is present' do
        subject = Factory.build(:product, name: 'Unavailable')
        subject.valid?
        subject.errors.messages[:name].length.should == 1
        subject = Factory.build(:product, name: 'Text Creation')
        subject.valid?.should == true
      end
    end
  end
end
