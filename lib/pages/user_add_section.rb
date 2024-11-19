class UserAddSection < Section
  me :css, "[data-test-id='add-broker-user-modal']"

  element :name_input, :css,"[data-test-id='first_name-input']"
  element :last_name_input, :css,"[data-test-id='last_name-input']"
  element :email_input,:css, "[data-test-id='email-input']"
  element :role_input, :css,"input[role='combobox'][name='role']"
  element :save, :css,"button[data-test-id='modal_success_button']"
  element :dropdown_item, :xpath, ->(name) { %(//li[descendant-or-self::*[text()="#{name}"]] | //*[(@role='menuitem' or @role='option') and contains(., "#{name}")]) }

  def fill_in_data(data)
    name_input_element.send_keys(data["First Name"])
    last_name_input_element.send_keys(data["Last Name"])
    email_input_element.send_keys(data["Email"])

    role_input_element.click
    role_input_element.send_keys(data["Role"])
    wait_for_ajax

    dropdown_item_element("Watch Officer").click
    sleep 1

    save_element.click
    sleep 1
  end
end
