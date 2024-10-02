module Tests
  class Update < Base
    def test_action

      create_params = {
        portal_id: 16288,
        title: SecureRandom.alphanumeric(11),
        custom_title: "some title",
        type: "Standard",
        latitude: "47.444956",
        longitude: "18.960501"
      }

      location = location_manager.create(create_params)

      update_params = {
        portal_id: 16288,
        title: SecureRandom.alphanumeric(11),
        custom_title: "UPDATED",
        id: location.id,
        type: "Standard",
        latitude: "47.144312",
        longitude: "21.64162"
      }

      updated_location = location_manager.update(update_params, location)

      aggregate_failures do
        expect(updated_location.custom_title).to eq("UPDATED")
        expect(updated_location.latitude).to eq(47.14431)
        expect(updated_location.longitude).to eq(21.64162)
        expect(updated_location.type).to eq("Standard")
      end

      after_action(location)
    end
  end
end

