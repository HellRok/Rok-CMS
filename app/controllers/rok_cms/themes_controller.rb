require_dependency "rok_cms/application_controller"

module RokCms
  class ThemesController < RokBase::ApplicationController
    load_and_authorize_resource :site, class: 'RokBase::Site'
    load_and_authorize_resource class: 'RokCms::Theme', through: :site, shallow: true
    decorates_assigned :themes, :theme
    before_filter :set_site, :theme_crumbs

    def index
      @themes = @themes.page(params[:page])
      @title = 'Themes'
    end

    def create
      if @theme.save
        flash[:success] = "#{@theme.name} theme is now live!"
        redirect_to site_themes_path(@site)
      else
        render :new
      end
    end

    def update
      if @theme.update_attributes(theme_params)
        flash[:success] = "#{@theme.name} has been updated."
        redirect_to site_themes_path(@site)
      else
        render :edit
      end
    end

    def destroy
      if @theme.destroy
        flash[:success] = "#{@theme.name} has been deleted."
        redirect_to site_themes_path(@site)
      else
        flash[:error] = @theme.errors.full_messages.to_sentence
        redirect_to site_themes_path(@site)
      end
    end

    private

    def theme_params
      params.require(:theme).permit(:name, :update_url, :version, :html, :scss, :javascript)
    end

    def theme_crumbs
      add_crumb 'Themes', site_themes_path(@site)

      if @theme.present?
        if @theme.persisted?
          add_crumb @theme.name
          @title = @theme.name
        else
          add_crumb 'New'
          @title = 'Theme'
        end
      end
    end
  end
end
