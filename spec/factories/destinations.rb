FactoryGirl.define do
    factory :destination do
        sequence(:name) {|n| "#{n}"}
    end
end