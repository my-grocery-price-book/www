namespace :eslint do
  desc 'run eslint against app/assets/javascripts'
  task :run do
    exec "eslint app/assets/javascripts/**/* | awk '{gsub(\"/vagrant/\", \"\")}1'"
  end
end
