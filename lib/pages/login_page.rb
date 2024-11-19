class LoginPage < Page
  path "/"
  validate :title, /Overhaul\z/

  element :user_email_input, :css, "#email"
  element :password_input, :css, "#password"
  element :submit_button, :css, "[data-test-id='sign-in-btn']"

  def login(user:, pass:)
    user_email_input_element.set(user)
    password_input_element.set(pass)
    submit_button_element.click
  end
end
