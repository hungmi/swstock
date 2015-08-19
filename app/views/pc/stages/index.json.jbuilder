json.array!(@pc_stages) do |pc_stage|
  json.extract! pc_stage, :id
  json.url pc_stage_url(pc_stage, format: :json)
end
