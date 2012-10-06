require 'faker'

class DbSeed
  USER_ROLES = {}
  
  attr_accessor :logger, :user_roles
  
  def initialize(options = {logger: nil})
    self.logger = options[:logger]
  end
  
  def create_fixtures
    create_roles
    create_users
    create_user_roles
  end
  
  protected
  
  def users
    return @users if @users
    
    @users = {}
    
    self.class::USER_ROLES.each do |role,attributes|
      @users[role] = attributes
      @users[role][:id] = User.find_by_name(role.to_s.humanize).id
    end
    
    @users
  end
  
  # roles 
  # TODO: define methods through USER_ROLES
  def user
    @user ||= User.find(user_id)
  end
  
  def user_id
    @user_id ||= users[:user][:id]
  end
  
  def tenant
    @tenant ||= User.find(tenant_id)
  end
  
  def tenant_id
    @tenant_id ||= users[:tenant][:id]
  end
  
  def log(message, type = :info)
    if logger 
      logger.send(type, message)
    else
      puts message
    end
  end
  
  def create_roles
    Role.import([:name], self.class::USER_ROLES.keys.map{|role| [role.to_s.humanize]})
    
    self.class::USER_ROLES.keys.each do |role|
      attributes = { name: role.to_s.humanize, public: [:project_owner, :user].include?(role) }
      
      "Role::#{role.to_s.classify}".constantize.create(attributes)
    end
  end
  
  def create_users
    self.class::USER_ROLES.each do |role, settings|
      attributes = {
        name: role.to_s.humanize, first_name: 'Mister', last_name: role.to_s.humanize, email: "#{role}@volontari.at",
        password: "#{role}2012", language: 'en', country: 'Germany', interface_language: 'en'
      }
      attributes[:password_confirmation] = attributes[:password]
      create_record(User, attributes, events: ['skip_confirmation!'])
    end
  end
  
  def create_user_roles
    UserRole.import(
      [:role_id, :user_id], users.keys.map{|r| [Role.find_by_name(r.to_s.humanize).id, users[r][:id]]}
    )
  end
  
  private
  
  def create_record(klass, attributes, options = {})
    options.assert_valid_keys(:events)
    
    klass = klass.constantize if klass.is_a?(String)
    events = options[:events] || []
    
    record = klass.new
    
    (attributes || {}).each {|attribute,value| record.send("#{attribute}=", value) }
    
    send_events(record, events) if events.any?
    
    record.save! if record.new_record?
    
    record
  end
  
  def send_events(object, events = [])
    events.each {|event| send_event(object, event) }
  end
  
  def send_event(object, event)
    object_was = object
    event_condition_class = "::DbSeed::EventConditions::#{object.class.table_name.classify}".constantize rescue nil
    arguments = nil
      
    if event.is_a?(Array)
      arguments = event
      event = arguments.shift
      
      if event == 'assignment'
        # TODO: YAGNI?
        object_was = object
        object = object.send(event)
        event = arguments.shift
        arguments = nil if arguments.none?
      end
    elsif event.is_a?(Proc)
      event.call(object)
      
      return
    end
    
    if event_condition_class && event_condition_class.respond_to?("before_#{event.gsub('!', '')}")
      conditions_arguments = arguments.is_a?(Array) ? [object] + arguments : [object]
      event_condition_class.send("before_#{event.gsub('!', '')}", *conditions_arguments)
    end

    if event_condition_class && event_condition_class.respond_to?(event.gsub('!', ''))
      # override event method through event condition class
      event_condition_class.send(event.gsub('!', ''), object)      
    else
      arguments ? object.send(event, *arguments) : object.send(event)
    end
    
    if event_condition_class && event_condition_class.respond_to?("after_#{event.gsub('!', '')}")
      conditions_arguments = arguments.is_a?(Array) ? [object] + arguments : [object]
      event_condition_class.send("after_#{event.gsub('!', '')}", *conditions_arguments)
    end
    
    object = object_was
  end
end
