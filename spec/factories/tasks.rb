FactoryBot.define do
  factory :task do
    title { Faker::Book.title }
    content { Faker::Books::Lovecraft.sentence }
  end
end
