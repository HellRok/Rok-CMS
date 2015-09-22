module RokCms
  class Page < ActiveRecord::Base
    include PageExtension
    acts_as_nested_set counter_cache: :children_count, order_column: :sort_order

    belongs_to :layout, class_name: 'RokCms::Layout'
    has_one :site, through: :layout, class_name: 'RokBase::Site'
    has_one :theme, through: :layout, class_name: 'RokCms::Theme'

    scope :published, -> { where(published: true) }
    scope :in_order, -> { order(:lft, :sort_order) }

    validates_presence_of :title, :slug, :layout_id, :content
    validates_length_of :title, :slug, maximum: 255
    validate :unique_for_site

    before_save :populate_path

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

    def select_display
      "#{'. . ' * depth} #{title}"
    end

    private
      # I almost want to have site_id just so I can do this at the DB level.
      def unique_for_site
        [[:title, title], [:slug, slug]].each do |attr|
          if site.pages.where(attr[0] => attr[1]).where.not(id: id).any?
            errors.add(attr[0], 'This is already taken within this site.')
          end
        end
      end

      def populate_path
        if parent && parent.path == '/'
          self.path = "/#{slug}"
        elsif parent
          self.path = [parent.path, slug].join('/')
        else
          self.path = '/'
        end
      end
  end
end
