if Rails.env.development?
  ActiveStorage::Current.host = 'http://localhost:3000' if ActiveStorage::Current.host.blank?
end
