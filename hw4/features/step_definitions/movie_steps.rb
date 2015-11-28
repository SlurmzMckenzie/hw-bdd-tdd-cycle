Given /the following movies exist/ do |movies_table|
	movies_table.hashes.each do |movie|
		Movie.create!(movie)
	end
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |movie, director|
	expect(page.body).to match(/#{movie}/m)
	expect(page.find('#details').text).to match(/Director: #{director}/m)
end


# ADDING IN TESTS FROM PREVIOUS HOMEWORK


Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
	#  ensure that that e1 occurs before e2.
	#  page.body is the entire content of the page as a string
	regexp = Regexp.new(/#{e1}.*#{e2}/)
	expect(page).to have_content(regexp)


end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
	# HINT: use String#split to split up the rating_list, then
	#   iterate over the ratings and reuse the "When I check..." or
	#   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	rating_list.split(",").each do |rating|
		if uncheck
			uncheck "ratings[#{rating}]"
		else
			check "ratings[#{rating}]"
		end
	end
	#fail "Unimplemented"
end

Then /^(?:|I )should see the ratings: (.*)/ do |rating_list|
	rating_list.split(",").each do |rating|
		regexp = Regexp.new(/^#{rating}/)

		if page.respond_to? :should
			page.should have_xpath('//*', :text => regexp)
		else
			assert page.has_xpath?('//*', :text => regexp)
		end
	end
end

Then /^(?:|I )should not see the ratings: (.*)/ do |rating_list|
	rating_list.split(",").each do |rating|
		regexp = Regexp.new(/^#{rating}/)

		if page.respond_to? :should
			page.should have_no_xpath('//*', :text => regexp)
		else
			assert page.has_no_xpath?('//*', :text => regexp)
		end
	end
end

When(/^I check all of the ratings$/) do
	all('input[type=checkbox]').each do |checkbox|
		if !checkbox.checked? then 
			checkbox.click
		end
	end
end

Then /I should see all the movies/ do
	# Make sure that all the movies in the app are visible in the table
	page.all('table#movies tr').count.should == 11

end
