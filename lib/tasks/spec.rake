namespace :spec do
  desc 'Run RSpec with precompiled assets'
  task :with_assets do
    Rake::Task['assets:precompile'].invoke
    Rake::Task['spec'].invoke
  end
end
