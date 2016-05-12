namespace :spec do
  desc 'run teaspoon tests'
  task :javascript do
    Rake::Task["teaspoon"].invoke
  end
end
