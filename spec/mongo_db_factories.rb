FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "product#{n}#{r_str}" }
    user_id User.first.try(:id) || Factory(:user).id
    area_ids [Factory(:area).id]
    text Faker::Lorem.sentences(5)
    
    after_build do |product|
      product.id = product.name.to_s.parameterize
    end
  end
end