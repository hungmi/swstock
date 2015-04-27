json.array!(@items) do |item|
  json.extract! item, :id, :location, :item_type, :picnum, :amount
  json.url item_url(item, format: :json)
end
