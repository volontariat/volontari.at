require 'spec_helper'

module ApplicationHelper
  def resource
    @resource ||= Factory(:vacancy)
  end
end

describe ApplicationHelper do
  describe '#general_attribute?' do
    it 'principally works' do
      general_attribute?(:state).should == true
      general_attribute?(:limit).should == false
    end
  end
  
  describe '#attribute_translation' do
    it 'principally works' do
      attribute_translation(:state).should == 'State'
      attribute_translation(:limit).should == 'Limit'
    end
  end
end