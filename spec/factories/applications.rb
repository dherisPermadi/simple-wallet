FactoryBot.define do
  factory :application, class: "Doorkeeper::Application" do
    name { "API Client" }
  end
end
