class SearchSuggestion
  def self.terms_for(prefix)
    $redis.zrevrange "search-suggestions:#{prefix.downcase}", 0, 9
  end
  
  def self.index_users
    User.find_each do |user|
      puts user.user_name
      index_term(user.user_name)
      index_term(user.first_name)
      index_term(user.last_name)
    end
  end
  
  def self.index_term(term)
    1.upto(term.length-1) do |n|
      prefix = term[0, n]
      $redis.zincrby "search-suggestions:#{prefix.downcase}", 1, term.downcase
    end
  end
end

