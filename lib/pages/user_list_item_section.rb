class UserListItemSection < Section
  me :css, '[data-test-id="table-row"]'

  element :name, :css, "[data-test-id='name']"
  element :email, :css, "[data-test-id='email']"
  element :role, :css, "[data-test-id='role']"
  element :phone, :css, "[data-test-id='phone']"

  def name
    name_element.text
  end

  def email
    email_element.text
  end

  def role
    role_element.text
  end

  def phone
    phone_element.text
  end

end
