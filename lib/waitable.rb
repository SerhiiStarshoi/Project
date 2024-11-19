module Waitable
  include RSpec::Matchers

  EXCEPTIONS_TO_RESCUE = [RSpec::Expectations::ExpectationNotMetError,
                          Selenium::WebDriver::Error::NoSuchElementError,
                          Selenium::WebDriver::Error::UnknownError,
                          Selenium::WebDriver::Error::StaleElementReferenceError,
                          Selenium::WebDriver::Error::WebDriverError]

  def wait_for_ajax
    wait_until(timeout: 30, interval: 1) do
      Capybara.page.evaluate_script("window.activeHttpCount === 0")
    end
  end

  def wait_until(timeout:, interval:)
    with_timeout(timeout, interval) { expect(yield).to be_truthy }
  end

  def with_timeout(timeout, interval, action_on_fail: nil, &block)
    start_time = Time.now

    begin
      result = block.call
    rescue *EXCEPTIONS_TO_RESCUE
      elapsed_time = Time.now - start_time
      raise if elapsed_time >= timeout

      sleep interval
      action_on_fail.call if action_on_fail.present?
      retry
    end

    result
  end
end
