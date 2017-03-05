class ProjectsController < ApplicationController
  active_tab :projects

  def show
    @partial      = params[:project].gsub('-', '_')
    @current_page = "projects/partials/#{@partial}"
  end
end
