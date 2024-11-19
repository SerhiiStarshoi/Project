class Page < Howitzer::Web::Page
  include Waitable

  def click(button_name)
    what_element = button_name.downcase.gsub(" ", "_") + "_element"
    send(what_element).click
  end
end
