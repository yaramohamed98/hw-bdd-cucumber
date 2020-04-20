# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
  
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should =~ /#{e1}.*#{e2}/m
  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  unless uncheck.eql? 'un'
    rating_list.split(',').each { |var| step %{I check "ratings_#{var}"} }
  else
    rating_list.split(',').each { |var| step %{I uncheck "ratings_#{var}"} }
  end
end

Then /I should see all the movies/ do
  expect(page.body.scan(/<tr>/).count).to eq(Movie.all.count + 1)
 
end
