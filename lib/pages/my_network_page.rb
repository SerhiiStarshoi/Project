class MyNetworkPage < Page
  path "/app/profile/network/carriers{?query_params*}"
  validate :title, /Overhaul App\z/

  element :manage_assets, :css, 'button[data-test-id="manage-carrier-assets-btn"]'
  element :add_asset, :css, "button[data-test-id='add-asset-btn']"

  element :asset_category, :css, "input[data-test-id='asset_class']"
  element :asset_type, :css, "input[data-test-id='kind']"
  element :asset_number, :css, "input[data-test-id='number']"
  element :asset_create, :css, "button[data-test-id='form-footer-submit-btn']"
  element :category_dropdown_item, :xpath, ->(name) { %(//li[descendant-or-self::*[text()="#{name}"]] | //*[(@role='menuitem' or @role='option') and contains(., "#{name}")]) }

  def fill_in_data(data, asset_number)
    asset_category_element.click
    asset_category_element.send_keys(data["Category"])
    wait_for_ajax
    category_dropdown_item_element(data["Category"]).click

    asset_type_element.click
    asset_type_element.send_keys(data["Type"])
    wait_for_ajax
    category_dropdown_item_element(data["Type"]).click

    asset_number_element.send_keys(asset_number)
    sleep 1
  end

  def create_asset
    asset_create_element.click
  end
end
