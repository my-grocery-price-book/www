namespace :eslint do
  desc 'npm install -g eslint'
  task :run do
    exec 'eslint app/assets/javascripts/**/*'
  end
end