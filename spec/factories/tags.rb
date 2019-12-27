FactoryBot.define do
  factory :tag do
    name { Faker::TvShows::Friends.character }
  end
end
