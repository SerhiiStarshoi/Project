require_relative "../manager"

module API
  module Assets
    class AssetManager < API::Manager

      def search(asset_number) #asset_number instead of id

        response = asset_call_search(asset_number)
        data = JSON.parse(response.body).first

        puts "DATA: #{data}"
        return nil if data.empty?

        asset_data = {
          "portal_id" => 16288,
          "id" => data["id"],
          "type" => data["type"],
          "number" => data["number"],
          "status" => data["status"]
        }
        Asset.new(asset_data)
      end

      def deactivate(asset_id)
        asset_call_deactivate(asset_id)
      end

      private

      def asset_call_search(query)
        search_url = "#{ENV['APP_URL']}/equipment-management/api/v1/vehicles/filter_list?page=1&per_page=10&query=#{query}"
        puts "Search url: #{search_url}"

        http.get(search_url)
      end

      def asset_call_deactivate(asset_id)
        puts "Asset id = #{asset_id}"
        deactivate_url = "#{ENV['APP_URL']}/equipment-management/api/v1/assets/#{asset_id}/deactivate"
        puts "Deactivate url: #{deactivate_url}"
        call_delete = http.put(deactivate_url)
        expect(call_delete.status).to eq(200)
        call_delete
        puts "Asset was deactivated successfully"
      end
    end
  end
end
