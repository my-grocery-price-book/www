module ApplicationHelper
  def react_server(component_name, args)
    react_component(component_name,args,prerender: true)
  end

  def react_render(args)
    MultiJson.load(render(args.merge(formats: [:json])))
  end
end
