require_relative "page"

class CommandCenterPage < Page
  path "/"
  validate :title, /Dashboard\z/

  def opened?
    command_center_url = "#{ENV['APP_URL']}/dashboard/command-center"
    if command_center_url.eql? current_url
      true
      else false
    end
  end
end
