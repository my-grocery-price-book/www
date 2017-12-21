# frozen_string_literal: true

namespace :spec do
  desc 'run javascript tests'
  task :javascript do
    exec 'yarn run jest'
  end
end
