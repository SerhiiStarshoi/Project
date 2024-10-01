module Tests
  class Deactivate < Base

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
      location_manager.delete(location)

      expect(location_manager.get_location(location).activated).to eq(false)
    end
  end
end
