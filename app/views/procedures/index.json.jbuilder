json.array!(@pc_procedures) do |pc_procedure|
  json.extract! pc_procedure, :id
  json.url pc_procedure_url(pc_procedure, format: :json)
end
