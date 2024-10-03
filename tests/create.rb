module Tests
  class Create < Base
    def test_action

      create_params = {
        portal_id: 16288,
        title: SecureRandom.alphanumeric(11),
        custom_title: "some title",
        type: "Standard",
        latitude: "47.444956",
        longitude: "18.960501"
      }

      puts location_manager.inspect

      location = location_manager.create(create_params)

      puts location.inspect

      expect(location.address).to eq("Budaörs, Akron Utca 2, 2040, Pest, Hungary")

      after_action(location)
    end
  end
end

#Tests::Create.new.whole_test




