Given /^I am on the "([^\"]*)" page$/ do |page_name|
  @browser.choose_ok_on_next_confirmation
  @browser.go_to url_for(page_name)
end

Given /^I go to the "([^\"]*)" page$/ do |page_name|
  Given "I am on the \"#{page_name}\" page"
end

When /^I should remain on the "([^\"]*)" page$/ do |page_name|
  @browser.wait_for_location_loaded url_for(page_name), 2
end

When /^I click the "([^\"]*)" button$/ do |button_name|
  @browser.click button_name
end

And /^I check the "([^\"]*)" check box$/ do |checkbox_name|
  @browser.check(checkbox_name)
end

And /^I uncheck the "([^\"]*)" check box$/ do |checkbox_name|
  if (@browser.get_value(checkbox_name) == "on")
      @browser.click checkbox_name
  end
end

When /^I click the "([^\"]*)" link$/ do |link|
  @browser.click "//a[text()='#{link}']"
end

When /^I click the "([^\"]*)" link and wait for the page to load$/ do |link|
  When "I click the \"#{link}\" link"
  @browser.wait_for_page_to_load
end

When /^I select "([^\"]*)" from the "([^\"]*)" dropdown list$/ do |option, dropdown_name|
  @browser.select_option dropdown_name, option
end

Then /^I should be taken to the "([^\"]*)" page$/ do |page_name|
  url = url_for(page_name)
  if url.is_a? Regexp
    @browser.url.should =~ url_for(page_name)
  else
    @browser.url.should == url_for(page_name)
  end

end

Given /^I type "([^\"]*)" into the "([^\"]*)" textbox$/ do |value, textbox_name|
  @browser.type textbox_name, value
end

When /^I select the "([^\"]*)" item in the "([^\"]*)" dropdown list$/ do |position, dropdown_name|
  @browser.select_option dropdown_name, "index=#{position.as_number}"
end

Then /^I should see the "([^\"]*)" form$/ do |form_title|
  @browser.get_text("//form/fieldset/legend[text()='#{form_title}']");
end

Then /^I should see the warning message "([^\"]*)"$/ do |warning_message|
  @browser.wait_for_text(warning_message, 10)
end

Then /^I should see the alert message "([^\"]*)"$/ do |warning_message|
  @browser.get_confirmation.should == warning_message
end

Then /^I wait for "([^\"]*)" seconds$/ do |seconds|
  sleep seconds.to_i
end

Then /^I should see "([^\"]*)" in the "([^\"]*)" textbox$/ do |text_value, textbox_id|
  @browser.get_value(textbox_id).should == text_value
end

Then /^I should see "([^\"]*)"$/ do |confirmation_message|
  @browser.wait_for_text(confirmation_message, 2)
end

Then /^I should see the link "([^\"]*)" with the url "([^\"]*)"$/ do |link_text, link_url|
  @browser.wait_for_element_present("//a[contains(text(), '#{link_text}') and @href='#{link_url}']", 10)
end

When /^I should not see the "([^\"]*)" link$/ do |link_text|
  @browser.assert_element_is_not_present "//a[text()='#{link_text}']"
end

When /^I select "([^\"]*)" from the "([^\"]*)" radio button list$/ do |value, radio_button_list_name|
  @browser.select_radio_button(radio_button_list_name, value)
end

Then /^the "([^\"]*)" check box should be checked$/ do |checkbox_name|
  @browser.get_value(checkbox_name).should == 'on'
end

Then /^the "([^\"]*)" check box should not be checked$/ do |checkbox_name|
  @browser.get_value(checkbox_name).should == 'off'
end

When /^the drop down "([^\"]*)" should have "([^\"]*)" selected$/ do |dropdown_name, selected_text|
  selected_value = @browser.get_value(dropdown_name)
  if(@browser.get_text("//select[@name='#{dropdown_name}']//option[@value='#{selected_value}']") !=  selected_text)
    raise "Unable to locate drop down #{dropdown_name} with selected text #{selected_text}"
  end
end

When /^the radio button "([^\"]*)" should have "([^\"]*)" selected$/ do |radio_button_name, selected_value|
  @browser.get_value("//input[@name='#{radio_button_name}' and @value='#{selected_value}']").should == 'on'
end

When /^I toggle the "([^\"]*)" check box$/ do |check_box_name|
  @browser.click check_box_name
end

When /^I click the "([^\"]*)" button and wait for the page to load$/ do |button_name|
  When "I click the \"#{button_name}\" button"
  @browser.wait_for_page_to_load
end

Then /^I see the "([^\"]*)" window with the url "([^\"]*)"$/ do |window_name, url|
  @browser.select_window("#{window_name}")
  And "I wait for \"3\" seconds"
  @browser.url.should == url
  @browser.select_window "null"
end

Then /^I should see the validation error "([^\"]*)"$/ do |expected_error|
  @browser.assert_element_is_present "//span[@class='field-validation-error' and text()='#{expected_error}']"
end

Then /^I should see the warning validation message "([^\"]*)"$/ do |expected_error|
  @browser.assert_element_is_present "//span[@class='warn_msg' and text()='#{expected_error}']"
end

Then /^the selected index of the "([^\"]*)" drop down is "([^\"]*)"/ do |dropdown_id, text_value|
  @browser.get_value(dropdown_id).should == text_value
end