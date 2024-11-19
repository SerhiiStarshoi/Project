class AssetManagerPage < Page
  path "/asset-management{?query_params*}"
  validate :title, /Asset Management\z/

  element :asset_list_item, :css, "div[data-test-id='search-result']"
  element :asset_status, :css , "div[data-test-id='motion-status']"

  def open_asset_details
    asset_list_item_element.click
    puts "Current url: #{current_url}"
  end

  def asset_status
    asset_status_element.text
  end

  def what_id
    current_url.match(/\/tractor\/(\d+)\?/)[1]
  end
end
