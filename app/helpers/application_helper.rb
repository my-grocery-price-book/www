module ApplicationHelper
  def prerender_react_component(name,args)
    react_component(name,args,prerender: true)
  end
end
