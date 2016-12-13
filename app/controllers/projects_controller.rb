class ProjectsController < ApplicationController
  active_tab :projects

  def show
    project = params[:project].gsub('-', '_')
    @current_page = "projects/partials/#{project}"
  end
end
