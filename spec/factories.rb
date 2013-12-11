require 'fileutils'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "foo#{n}@example.com" }
    city "St. Charles"
    state "Illinois"
    country "United States"
    password "password"
    password_confirmation "password"
  end
  
  factory :admin do
    admin true
  end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
end
