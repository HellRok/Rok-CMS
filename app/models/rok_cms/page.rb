module RokCms
  class Page < ActiveRecord::Base
    include PageExtension
    belongs_to :layout, class_name: 'RokCms::Layout'
    has_one :site, through: :layout, class_name: 'RokBase::Site'
    has_one :theme, through: :layout, class_name: 'RokCms::Theme'

    scope :published, -> { where(published: true) }

    validates_presence_of :title, :slug, :layout_id, :content
    validates_uniqueness_of :title, :slug, scope: :site
    validates_length_of :title, :slug, maximum: 255

    def assets_updated_at
      [theme, site].map(&:updated_at).max
    end

    def generate_html
      # TODO: make this waaaay better
      html = layout.content
      content = JSON.parse(self.content)

      html = html.gsub("\\[", "[").gsub("\\]", "]")

      layout.get_blocks.each do |block|
        html.gsub!("[[#{block}]]", content[block.split(':').last])
      end

      theme.render(html)
    end

    def render
      Liquid::Template.parse(generate_html).render(
        'site' => RokBase::SiteDrop.new(site),
        'page' => RokCms::PageDrop.new(self),
      )
    end
  end
end
