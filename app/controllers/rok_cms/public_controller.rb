require_dependency "rok_cms/application_controller"

module RokCms
  class PublicController < ApplicationController
    before_filter :load_site

    def show
      @page = @site.find_request(request.fullpath)
      raise ActionController::RoutingError.new('Not Found') unless @page
      render text: @page.render, layout: false
    end

    def load_site
      @site = RokBase::Site.find_by_host(request.host)
      raise ActionController::RoutingError.new('Not Found') unless @site.present?
    end
  end
end
