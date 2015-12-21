require_dependency "rok_cms/application_controller"

module RokCms
  class PagesController < RokBase::ApplicationController
    load_and_authorize_resource :site, class: 'RokBase::Site'
    load_and_authorize_resource class: 'RokCms::Page', through: :site, shallow: true
    decorates_assigned :pages, :page
    before_filter :set_site, :page_crumbs, :stamp

    def index
      @pages = @pages.in_order
      @title = 'Pages'
    end

    def new
      # Need some sort of default
      @page.layout = @site.layouts.first
    end

    def create
      if @page.save
        flash[:success] = "#{@page.title} page is now live!"
        redirect_to site_pages_path(@page.site)
      else
        render :new
      end
    end

    def update
      if @page.update_attributes(page_params)
        flash[:success] = "#{@page.title} has been updated."
        redirect_to site_pages_path(@page.site)
      else
        render :edit
      end
    end

    def destroy
      if @page.destroy
        flash[:success] = "#{@page.title} has been deleted."
        redirect_to site_pages_path(@site)
      else
        flash[:error] = @page.errors.full_messages.to_sentence
        redirect_to site_pages_path(@site)
      end
    end

    private

      def page_params
        params.require(:page).permit(:title, :slug, :content, :layout_id, :published,
          :parent_id)
      end

      def page_crumbs
        add_crumb 'Pages', site_layouts_path(@site)

        if @page.present?
          if @page.persisted?
            add_crumb @page.title
            @title = @page.title
          else
            add_crumb 'New'
            @title = 'Page'
          end
        end
      end
  end
end
