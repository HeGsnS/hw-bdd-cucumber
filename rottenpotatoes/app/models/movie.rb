class Movie < ActiveRecord::Base
  # all_ratings method
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  # with_ratings method 
    def self.with_ratings(ratings)
        where("LOWER(rating) IN (?)", ratings.map(&:downcase))
    end
end
