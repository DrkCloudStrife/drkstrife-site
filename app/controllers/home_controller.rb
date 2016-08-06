class HomeController < ApplicationController
  active_tab :home

  def index
    self.class.active_tab = :home
  end

  def about
    self.class.active_tab = :about
  end
end
