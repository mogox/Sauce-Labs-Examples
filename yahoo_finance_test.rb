require "rubygems"
gem "rspec"
gem "selenium-client"
require "selenium/client"
require "selenium/rspec/spec_helper"

describe "yahoo_finance_test" do
  attr_reader :selenium_driver
  alias :page :selenium_driver

  before(:all) do
    @verification_errors = []
    @selenium_driver = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*chrome",
      :url => "http://www.yahoo.com/",
      :timeout_in_second => 60
  end

  before(:each) do
    @selenium_driver.start_new_browser_session
  end
  
  append_after(:each) do
    @selenium_driver.close_current_browser_session
    @verification_errors.should == []
  end
  
  it "test_yahoo_finance_test" do
    page.open "/"
    page.wait_for_page_to_load "60000"
    page.click "link=Finance (DowUp)"
    page.wait_for_page_to_load "60000"
    page.type "css=input.get-quotes-box", "LNKD"
    page.click "css=input.get-quotes-button"
    page.wait_for_page_to_load "60000"
    page.is_text_present("LinkedIn Corporation").should be_true
  end
end
