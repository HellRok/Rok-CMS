class RokCms::LayoutDecorator < Draper::Decorator
  delegate_all

  def to_s
    name
  end
end
