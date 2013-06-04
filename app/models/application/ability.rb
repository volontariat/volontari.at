class Application::Ability
  include CanCan::Ability

  def initialize(user, options = {})
    if user.present?
    end
  end
end
