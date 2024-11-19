module API
  module Assets
    class Asset

      attr_reader :portal_id, :id, :type, :number, :status

      def initialize(data)
        @portal_id = data["portal_id"]
        @id = data["id"]
        @type = data["type"]
        @number = data["number"]
        @status = data["status"]
      end

      private

      attr_reader :data
    end
  end
end
