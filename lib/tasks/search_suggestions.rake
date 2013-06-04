namespace :search_suggestions do
  desc "Generate example search suggestions"
  task :index => :environment do
    SearchSuggestion.index_users
  end
end
