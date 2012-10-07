require 'spec_helper'

describe Task do
  describe 'validations' do
    describe 'reserved_words_exclusion' do
      it 'assures that no reserved word has been chosen' do
        subject = Task.new(name: 'next')
        subject.valid?
        subject.errors.messages[:name].length.should == 1
      end
    end
  end
end
