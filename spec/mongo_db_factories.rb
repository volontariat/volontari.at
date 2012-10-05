FactoryGirl.define do
  factory :product do
    name 'Text Creation'
    user_id User.first.try(:id) || Factory(:user).id
    area_ids [Area.first.try(:id) || Factory(:area).id]
    text Faker::Lorem.sentences(5)
    
    after_build do |product|
      product.id = product.name.to_s.parameterize
    end
  end
end