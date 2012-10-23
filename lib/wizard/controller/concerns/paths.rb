module Wizard::Controller::Concerns::Paths
  extend ActiveSupport::Concern

  included do
    # Give our Views helper methods!
    helper_method :wizard_path, :next_wizard_path, :previous_wizard_path
  end

  def next_wizard_path(options = {})
    wizard_path(@next_step, options)
  end

  def previous_wizard_path(options = {})
    wizard_path(@previous_step, options)
  end

  def wizard_path(goto_step = nil, options = {})
    url_for(
      { 
        controller: controller_name, action: goto_step,
        id: params[:id], only_path: true
      }.merge options
    )
  end
end
