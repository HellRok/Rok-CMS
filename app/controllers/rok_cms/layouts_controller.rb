require_dependency "rok_cms/application_controller"

module RokCms
  class LayoutsController < RokBase::ApplicationController
    load_and_authorize_resource :site, class: 'RokBase::Site'
    load_and_authorize_resource class: 'RokCms::Layout', through: :site, shallow: true
    decorates_assigned :layouts, :layout
    before_filter :set_site, :layout_crumbs

    def index
      @layouts = @layouts.page(params[:page])
      @title = 'Layouts'
    end

    def create
      if @layout.save
        flash[:success] = "#{@layout.name} layout is now live!"
        redirect_to site_layouts_path(@site)
      else
        render :new
      end
    end

    def update
      if @layout.update_attributes(layout_params)
        flash[:success] = "#{@layout.name} has been updated."
        redirect_to site_layouts_path(@site)
      else
        render :edit
      end
    end

    private

    def layout_params
      params.require(:layout).permit(:name, :content, :theme_id)
    end

    def layout_crumbs
      add_crumb 'Layouts', site_layouts_path(@site)

      if @layout.present?
        if @layout.persisted?
          add_crumb @layout.name
          @title = @layout.name
        else
          add_crumb 'New'
          @title = 'Layout'
        end
      end
    end
  end
end