require 'rubygems'
require 'spec/expectations'
require 'selenium'
require 'net/http'
require 'uri'
require 'json'
require 'dbi'
require 'cucumber'
require 'mechanize'
require 'active_record'


class HolidaysDb < ActiveRecord::Base
  
end


if ENV['no_browser'] == 'true'
  browser = Mechanize.new
else
  browser = Selenium::SeleniumDriver.new("localhost", 5555, "*chrome", "http://localhost", 150000)
  browser.set_speed 5
  browser.start
  browser.allow_native_xpath true
end

current_user = ENV['current_user'] || ENV['USERNAME']

Before do
  if ENV['no_browser'] == 'true'
    @browser = BrowserDriverMechanize.new(browser)
  else
    @browser = BrowserDriverSelenium.new(browser)
  end
  @current_user = current_user
  @database_cleaner = DatabaseCleaner.new()
  @database_cleaner.reset_database()
end

After do |scenario|
  if (scenario.failed?)
	file_name = scenario.name.gsub(' ', '_').gsub('|', ' ').gsub('/', ' ')
	image_path = File.join(File.expand_path(File.dirname(__FILE__)),"../../../../metrics/AcceptanceTests/Holidays/#{file_name}.png")
    @browser.capture_entire_page_screenshot image_path
  end
end

at_exit do
  if not ENV['no_browser']
    browser.stop
  end
end