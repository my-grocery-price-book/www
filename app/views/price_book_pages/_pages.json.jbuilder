json.array! pages do |page|
  json.partial! 'page', page: page, store_ids: store_ids
end
