module RokCms
  class Theme < ActiveRecord::Base
    include ThemeExtension
    before_save :compile_scss

    validates_presence_of :name, :version, :html
    validates_uniqueness_of :name, scope: :site
    validates_length_of :name, :update_url, maximum: 255

    belongs_to :site, class_name: 'RokBase::Site'
    belongs_to :created_by, class_name: RokBase.user_class, foreign_key: :creator_id
    belongs_to :updated_by, class_name: RokBase.user_class, foreign_key: :updater_id
    has_many :layouts, class_name: 'RokCms::Layout', dependent: :restrict_with_error

    def render(content)
      html.gsub('[[yield]]', content)
    end

    private

    def compile_scss
      # TODO: Proper error handling instead of exploding
      self.compiled_css = Sass.compile(self.scss, style: :compressed) if self.scss.present?
    end
  end
end
