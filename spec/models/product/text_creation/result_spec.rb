require 'spec_helper'

describe Product::TextCreation::Result do
  describe 'validations' do
    describe '#text_length_between_range' do
      it 'principally works' do
        story = FactoryGirl.create(:story)
        task = story.tasks.first
        subject = Product::TextCreation::Result.new(task_id: task.id, text: 'Dummy')
        subject.valid?.should == false
        subject.text = 'Dummy      '
        subject.valid?.should == false
        subject.text = 'Dummy Dummy'
        subject.valid?.should == true
      end
    end
  end
end
