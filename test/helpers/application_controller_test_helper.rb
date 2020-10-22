class ApplicationControllerTest < ActionController::TestCase

  class_attribute :active_tab

  def self.active_tab( tab=nil )
    self.active_tab = tab
  end

end
