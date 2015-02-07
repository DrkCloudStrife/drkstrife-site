module Haml::Filters

  remove_filter("Markdown")

  module Markdown
    include Haml::Filters::Base

    def render(text)
      markdown.render text
    end

  private

    def markdown
      @markdown ||= Redcarpet::Markdown.new Redcarpet::Render::HTML, {
        autolink:         true,
        fenced_code:      true,
        hard_wrap:        true,
        no_intraemphasis: true,
        strikethrough:    true,
        tables:           true,
      }
    end

  end
end
