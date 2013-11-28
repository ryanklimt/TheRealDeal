namespace :db do
  desc "Sequentially clears out the models I don't care about"
  task :reset_topics => :environment do
    puts "Clearing out the Topic model"
    Topic.destroy_all
    puts "Finished."
  end
end