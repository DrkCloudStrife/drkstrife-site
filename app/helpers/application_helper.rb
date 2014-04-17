module ApplicationHelper

  def canonical_link
    link = 'http://'
    link += request.host.downcase
    link += request.path.downcase[current_locale.length+1...request.path.length]

    link
  end

end
