FactoryBot.define do
  factory :patient do
    first_name { "John" }
    last_name { "Doe" }
    email { "john.doe@example.com" }
  end
end
