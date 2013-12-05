namespace :db do
  desc "Sequentially clears out the models I don't care about"
  task :reset_wallposts => :environment do
    puts "Clearing out the Wallpost model"
    Wallpost.destroy_all
    puts "Finished."
  end
end