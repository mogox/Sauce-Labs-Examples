require "rubygems"
gem "rspec"
gem "selenium-client"
require "selenium/client"
require "selenium/rspec/spec_helper"

describe "zip_code_check_ie9" do
  attr_reader :selenium_driver
  alias :page :selenium_driver

  before(:all) do
    @verification_errors = []
    @selenium_driver = Selenium::Client::Driver.new \
      :host => "ondemand.saucelabs.com",
      :port => 80,
      :browser => "{\"username\": \"PUTYOUR_USERNAME\",\"access-key\":\"AAAAAAAAAAAA_0\",\"browser\": \"iehta\",\"browser-version\":\"9\",\"job-name\":\"zip_code_check\",\"max-duration\":1800,\"record-video\":true,\"user-extensions-url\":\"\",\"os\":\"Windows 2008\"}",
      :url => "http://jade-staging.wellnessfx.com/",
      :timeout_in_second => 60
  end

  before(:each) do
    @selenium_driver.start_new_browser_session
  end

  append_after(:each) do
    @selenium_driver.close_current_browser_session
    @verification_errors.should == []
  end

  it "test_zip_code_check_ie9" do
    page.open "/"
    page.wait_for_page_to_load "60000"
    page.click "css=a.availability"
    page.type "id=zip", "90210"
    page.key_press "id=zip", "\\13"
  end
end
