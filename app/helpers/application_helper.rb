# frozen_string_literal: true

module ApplicationHelper
  def react_server(component_name, args)
    react_component(component_name, args)
  end

  def props_component(component_name, props)
    react_component(component_name, props)
  end

  def react_render(args)
    MultiJson.load(render(args.merge(formats: [:json])))
  end

  # make sure json formats it as a float and not a string
  def safe_float_for_json(amount)
    Float(format('%.12g', amount))
  end
end
