Capybara.register_driver :selenium do |app|
  args = []
  args << "window-size=1920,1080"
  args << "start-fullscreen" if Howitzer.maximized_window

  options = Selenium::WebDriver::Chrome::Options.new(args: args)

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end