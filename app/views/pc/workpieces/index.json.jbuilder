json.array!(@pc_workpieces) do |pc_workpiece|
  json.extract! pc_workpiece, :id
  json.url pc_workpiece_url(pc_workpiece, format: :json)
end
