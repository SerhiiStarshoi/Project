Capybara.configure do |config|
  config.run_server = false
  config.app_host = nil
  config.asset_host = Howitzer.app_uri.origin
  config.default_selector = :css
  config.default_max_wait_time = 30
  config.ignore_hidden_elements = true
  config.match = :one
  config.exact = true
  config.visible_text_only = true
  config.default_driver = Howitzer.driver.to_s.to_sym
  config.javascript_driver = Howitzer.driver.to_s.to_sym
end