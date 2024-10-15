require "http"
require "rspec"
require "selenium-webdriver"

class Uitest

  attr_reader :driver, :wait
  attr_accessor :url_link

  def initialize
    @url_link = url_link
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
  end

  include RSpec::Matchers

  PAGE_URL = "#{ENV['APP_URL']}"
  def print_url
    puts "URL: #{PAGE_URL}".inspect
  end

  def page_call_open
    page_response = HTTP.get(PAGE_URL)
    expect(page_response.status).to eq(200)
    page_response
  end

  def log_in
    begin
      driver.get PAGE_URL
      driver.current_url
      username = wait.until { driver.find_element(id: "email") }
      password = wait.until { driver.find_element(id: "password") }

      username.send_keys(ENV['EMAIL'])
      password.send_keys(ENV['PASSWORD'])

      login_button = wait.until { driver.find_element(css: '[data-test-id="sign-in-btn"]')  }
      login_button.click
    ensure
      driver.quit
    end

  end
end
