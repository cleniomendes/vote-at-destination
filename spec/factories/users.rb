FactoryGirl.define do
  factory :user do
      name "Clenio"
      email "clenio.si@gmail.com"
  end
  
  factory :invalid_user, class: User do |f|
    f.name nil
  end
end