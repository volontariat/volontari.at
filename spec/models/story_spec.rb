require 'spec_helper'

describe Product do
  describe 'member methods' do
    describe 'next_task_for_user' do
      it 'principally works' do
        subject = Factory(:story)
        subject.activate!
        user = Factory(:user)
        
        next_task = subject.next_task_for_user(user)
        next_task.id.should == subject.tasks.first.id
        
        next_task = subject.next_task_for_user(user)
        next_task.id.should == subject.tasks.first.id
        Product.stories(subject.product_id, user, 1).count.should == 1
        
        next_task.cancel!
        next_task = subject.next_task_for_user(user)
        next_task.should == nil
        subject.users_without_tasks_ids.include?(user.id).should == true
        Product.stories(subject.product_id, user, 1).count.should == 0
      end
    end
  end
end
