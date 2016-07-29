module ApplicationHelper
  def react_server(component_name, args)
    react_component(component_name, args, prerender: true)
  end

  def react_render(args)
    MultiJson.load(render(args.merge(formats: [:json])))
  end

  def embedded_svg(filename, options = {})
    # Cache the result of the parsing svg for next render
    sanitize(
      Rails.cache.fetch("embedded_#{filename}_#{options.hash}") do
        file = File.read(Rails.root.join('app', 'assets', 'images', filename))
        doc = Nokogiri::HTML::DocumentFragment.parse file
        svg = doc.at_css 'svg'
        svg['class'] = options[:class] if options[:class].present?
        doc.to_html
      end
    )
  end
end
