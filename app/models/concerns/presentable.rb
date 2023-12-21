module Presentable

  extend ActiveSupport::Concern
  extend ActiveStorage::SetCurrent

  def decorate
    "#{self.class}Presenter".constantize.new(self)
  end

end
