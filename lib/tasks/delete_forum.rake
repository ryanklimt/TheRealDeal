namespace :db do
  desc "Sequentially clears out the models I don't care about"
  task :reset_forum => :environment do
    puts "Clearing out the Forum model"
    Forum.destroy_all
    puts "Finished."
  end
end