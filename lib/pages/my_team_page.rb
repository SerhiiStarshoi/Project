require_relative "page"

class MyTeamPage < Page
  path "/app/profile/team/brokers{?query_params*}"
  validate :title, /Overhaul App\z/

  section :user_list_item
  section :user_add

  element :add_user, :css, 'button[data-test-id="add-broker-user-btn"]'

  element :deactivate_user_button, :css, '[data-test-id="deactivate-broker-user-btn"]'
  element :deactivate_user_button_confirm, :css, '[data-test-id="modal_success_button"]'

  element :save, :css, "button[data-test-id='modal_success_button']"

  def user_by_name(name)
    user_list_item_sections.find { |user| user.name == name }
  end

  def deactivate_user_ui
    deactivate_user_button_element.click
    deactivate_user_button_confirm_element.click
  end
end
