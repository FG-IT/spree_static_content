module Spree
  module Api
    module V1
      class PagesController < Spree::Api::BaseController
        def index
          @pages = if params[:ids]
                        ::Spree::StaticPage.finder_scope.by_store(current_store).where(id: params[:ids].split(',').flatten)
                      else
                        ::Spree::StaticPage.finder_scope.by_store(current_store).ransack(params[:q]).result
                      end

          @pages = @pages.distinct.page(params[:page]).per(params[:per_page])
          expires_in 24.hours, public: true
          headers['Surrogate-Control'] = "max-age=#{24.hours}"
          respond_with(@pages)
        end
      end
    end
  end
end