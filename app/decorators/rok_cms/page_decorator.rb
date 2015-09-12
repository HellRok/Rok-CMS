module RokCms
  class PageDecorator < Draper::Decorator
    delegate_all
    decorates_association :layout
  end
end
