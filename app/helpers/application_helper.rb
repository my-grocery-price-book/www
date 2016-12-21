# frozen_string_literal: true
module ApplicationHelper
  def react_server(component_name, args)
    react_component(component_name, props: args, prerender: true)
  end

  def props_component(component_name, props)
    react_component(component_name, props: props)
  end

  def react_render(args)
    MultiJson.load(render(args.merge(formats: [:json])))
  end

  # def embedded_svg(filename, options = {})
  #   # Cache the result of the parsing svg for next render
  #   # rubocop:disable Rails/OutputSafety
  #   Rails.cache.fetch("embedded_#{filename}_#{options.hash}") do
  #     file = File.read(Rails.root.join('app', 'assets', 'images', filename))
  #     doc = Nokogiri::HTML::DocumentFragment.parse file
  #     svg = doc.at_css 'svg'
  #     svg['class'] = options[:class] if options[:class].present?
  #     doc.to_html
  #   end.html_safe
  #   # rubocop:enable Rails/OutputSafety
  # end
end
