def r_str
  SecureRandom.hex(3)
end

def resource_has_many(resource, association_name)
  association = if resource.send(association_name).length > 0
    nil
  elsif association_name.to_s.classify.constantize.any?
    association_name.to_s.classify.constantize.last
  else
    Factory.create association_name.to_s.singularize.to_sym
  end
  
  resource.send(association_name).send('<<', association) if association
end

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user#{n}#{r_str}" }
    sequence(:email) { |n| "user#{n}#{r_str}@volontari.at" }
    first_name 'Mister'
    last_name { |u| u.name.humanize }
    country 'Germany'
    language 'en'
    interface_language 'en'
    password 'password'
    password_confirmation { |u| u.password }
  end
  
  factory :area do
    sequence(:name) { |n| "area #{n}" }
  end
  
  factory :project do
    association :user
    sequence(:name) { |n| "project #{n}" }
    text Faker::Lorem.sentences(20)
    
    after_build do |project|
      resource_has_many(project, :areas) 
    end
  end
  
  factory :vacancy do
    association :project
    sequence(:name) { |n| "vacancy #{n}" }
    text Faker::Lorem.sentences(20)
    limit 1
    state 'open'
  end
  
  factory :candidature do
    association :user
    association :vacancy
    sequence(:name) { |n| "candidature #{n}" }
    text Faker::Lorem.sentences(20)
  end
  
  factory :comment do
    association :user
    association :commentable, factory: :project
    sequence(:name) { |n| "comment #{n}" }
    text Faker::Lorem.sentences(5)
  end
end
