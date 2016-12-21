# frozen_string_literal: true
namespace :spec do
  desc 'run javascript tests'
  task :javascript do
    exec 'npm run test'
  end
end
