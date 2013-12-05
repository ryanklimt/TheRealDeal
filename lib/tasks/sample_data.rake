namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(username: "Admin",
                 email: "admin@admin.com",
                 password: "password",
                 password_confirmation: "password",
                 admin: true )
    40.times do |n|
      username = 'example_user' + n.to_s
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(username: username,
                   email: email,
                   password: password,
                   password_confirmation: password)
      end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.wallposts.create!(content: content) }
      end
  end
end