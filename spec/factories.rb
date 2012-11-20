def r_str
  SecureRandom.hex(3)
end

def resource_has_many(resource, association_name)
  association = if resource.send(association_name).length > 0
    nil
  elsif association_name.to_s.classify.constantize.count > 0
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
    
    #after_create do |user|
    #  User.confirm_by_token(user.confirmation_token)
    #end
  end
  
  factory :area do
    sequence(:name) { |n| "area #{n}" }
  end
  
  factory :product do
    name 'Text Creation'
    user_id Factory(:user, password: 'password', password_confirmation: 'password').id
    area_ids [Area.first.try(:id) || Factory(:area).id]
    text Faker::Lorem.sentences(5).join(' ')
    
    after_build do |product|
      product.id = product.name.to_s.parameterize
    end
  end
  
  factory :project do
    association :user
    sequence(:name) { |n| "project #{n}#{r_str}" }
    text Faker::Lorem.sentences(20).join(' ')
    
    after_build do |project|
      resource_has_many(project, :areas) 
    end
  end
  
  factory :text_creation_project, parent: :project do
    product_id (Product.where(name: 'Text Creation').first || Factory(:product)).id
  end
  
  factory :vacancy do
    association :project
    sequence(:name) { |n| "vacancy #{n}" }
    text Faker::Lorem.sentences(20).join(' ')
    limit 1
    state 'open'
  end
  
  factory :candidature do
    association :user
    association :vacancy
    sequence(:name) { |n| "candidature #{n}" }
    text Faker::Lorem.sentences(20).join(' ')
  end
  
  factory :comment do
    association :user
    association :commentable, factory: :project
    sequence(:name) { |n| "comment #{n}" }
    text Faker::Lorem.sentences(5).join(' ')
  end
  
  factory :story, class: Product::TextCreation::Story do
    project_id Factory(:text_creation_project).id
    sequence(:name) { |n| "story#{n}#{r_str}" }
    text Faker::Lorem.sentences(10).join(' ')
    language 'en'
    min_length 10
    max_length 50
    with_keywords true
    min_number_of_keywords 1
    max_number_of_keywords 3
    event 'setup_tasks'
    state_before 'initialized'
    state 'tasks_defined'
    
    after_build do |story|
      story.tasks << Factory.build(:text_creation_task)
    end
  end
  
  factory :story_without_tasks, class: Product::TextCreation::Story do
    project_id Project.first.try(:id) || Factory(:text_creation_project).id
    sequence(:name) { |n| "story#{n}#{r_str}" }
    text Faker::Lorem.sentences(10).join(' ')
    language 'en'
    min_length 10
    max_length 50
    with_keywords true
    min_number_of_keywords 1
    max_number_of_keywords 3
    event 'initialization'
    state_before 'new'
    state 'initialized'
  end
  
  factory :task do
    sequence(:name) { |n| "task#{n}#{r_str}" }
    text Faker::Lorem.sentences(10).join(' ')
  end
  
  factory :text_creation_task, class: Product::TextCreation::Task do
    sequence(:name) { |n| "task#{n}#{r_str}" }
    keywords 'Keyword 1'
  end
end
