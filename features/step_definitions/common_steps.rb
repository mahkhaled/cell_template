Then /^(?:|I )should see tag "([^"]*)"$/ do |selector|
  response.should have_selector(selector)
end

Then /^(?:|I )should not see tag "([^"]*)"$/ do |selector|
  response.should_not have_selector(selector)
end

Then /^I should see tag "([^"]*)" (\d+) times$/ do |selector, count|
  response.should have_selector(selector, :count=>count.to_i)
end

When /^(?:|I )submit the form "([^"]*)"$/ do |name|
  submit_form(name)
end

When /^(?:|I )submit the form "([^"]*)" within "([^"]*)"$/ do |name, selector|
  within(selector) do |content|
    content.submit_form(name)
  end
end

When /^I select "([^"]*)" from "([^"]*)" within "([^"]*)"$/ do |value, field, selector|
  within(selector) do |content|
    content.select(value, :from => field)
  end
end

Given /^it is "([^"]*)" at "([^"]*)" now$/ do |date, time|
  date_time = Time.parse("#{date}, #{time}")
  Time.stub!(:now).and_return(date_time)
end

Given /^the auto detected zone is "([^"]*)"$/ do |zone|
  ZoneDetector.stub!(:get_info_by_ip).and_return({
    "TimezoneName" => zone
  })
end

When /^(?:|I )(?:reload|refresh) the current page$/ do
  reload
end

When /^(?:|I )go back$/ do
  visit request.env['HTTP_REFERER']
end
