require_dependency "rok_cms/application_controller"

module RokCms
  class CmsAssetsController < PublicController
    skip_before_filter :verify_authenticity_token

    def show
      theme = @site.themes.find_by(id: params[:theme_id])

      str = ''
      respond_to do |format|
        format.css do
          str << @site.compiled_css if @site.compiled_css.present?
          str << theme.compiled_css if theme.compiled_css.present?
        end
        format.js do
          str << @site.javascript if @site.javascript.present?
          str << theme.javascript if theme.javascript.present?
        end
      end

      render text: str
    end
  end
end
