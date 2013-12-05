namespace :db do
  desc "Sequentially clears out the models I don't care about"
  task :reset_users => :environment do
    puts "Clearing out the User model"
    User.destroy_all
    puts "Finished."
  end
end