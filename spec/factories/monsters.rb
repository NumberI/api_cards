FactoryGirl.define do
  factory :monster do
    sequence :name do |n|
      "Monster #{n}"
    end
    power "ololo"
    type "fire"
    user_id 1
  end
end
