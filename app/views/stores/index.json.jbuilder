json.array!(@stores) do |store|
  json.extract! store, :id, :tax_rate
  json.url store_url(store, format: :json)
end
