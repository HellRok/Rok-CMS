module RokCms
  class PageDrop < RokBase::BaseDrop
    def initialize(page)
      @object = page
    end

    def title
      @object.title
    end

    def url
      # TODO: build this properly
      @object.slug
    end
  end
end
