Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |certain_movie|
    # create movie list
    Movie.create!(title: certain_movie[:title], rating: certain_movie[:rating], release_date: certain_movie[:release_date])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |mov1, mov2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(/[\s\S]*#{mov1}[\s\S]*#{mov2}/).to match(page.body)
end

###############################################################
###############################################################
###############################################################

When /^I press "(.*)" button/ do |abutton|
  # create the virual action to click the button
  click_button abutton
end

Then /I should (not )?see the following movies: (.*)$/ do |present, movies_list|
  movies = movies_list.split(', ')
  movies.each do |certain_movie|
    if present.nil?
      # expect to have the content
      expect(page).to have_content(certain_movie)
    else
      expect(page).not_to have_content(certain_movie)
    end
  end
end

###############################################################
###############################################################
###############################################################

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  all_mov_ratings = rating_list.split(', ')
  all_mov_ratings.each do |certain_rating|
    uncheck ? uncheck("ratings[#{certain_rating}]") : (check("ratings[#{certain_rating}]"))
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  expect(page).to have_xpath("//tr", count: 11)
end
