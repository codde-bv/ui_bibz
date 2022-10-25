# frozen_string_literal: true

require 'ui_bibz/utils/internationalization'
module UiBibz::Ui
  class Base
    include ActionView::Helpers
    include Rails.application.routes.url_helpers

    attr_accessor :output_buffer

    # To know if translation missing
    def i18n_set?(key)
      I18n.t key, raise: true
    rescue StandardError
      false
    end

    # Add "id" in url to match with current record
    def inject_url(url, record)
      url.gsub(%r{(/id/?)}, "/#{record.id}/")
    end

    def generate_id(name = nil)
      "#{name || 'id'}-#{Random.rand(99_999)}"
    end

    def _fix_haml6_block(&block)
      # <https://github.com/haml/haml/issues/1104>
      proc { block.binding.receiver.with_output_buffer(&block) }
    end

    def render
      if respond_to? :pre_render
        pre_render
      else
        super
      end
    end
  end
end
