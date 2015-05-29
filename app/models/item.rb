class Item < ActiveRecord::Base
  before_save :setDefaultValue
  validates :picnum, presence: true

  def setDefaultValue
    self.finished ||= '0'
    self.unfinished ||= '0'
  end

  def self.multiSearch(queries)
      queries = queries.strip.split(/\s+/)
      querySQL = ""
      queries.each do |query|
          if querySQL.blank? then
              querySQL = where("location like ? OR item_type like ? OR picnum like ? OR oldpicnum like ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
          else
              querySQL = querySQL + where("location like ? OR item_type like ? OR picnum like ? OR oldpicnum like ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
          end
      end
      return querySQL0
  end

  def self.search(query)
      where("lower(location) like ? OR lower(item_type) like ? OR lower(picnum) like ? OR lower(oldpicnum) like ?", ("%#{query}%").downcase, ("%#{query}%").downcase, ("%#{query}%").downcase, ("%#{query}%").downcase)
  end

  def self.import(file)
    invalidProductNum = 0
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      #之後要匯入ID的話要修改這邊
      #product.attributes = parameters.permit(:id, :location, :item_type, :picnum, :oldpicnum, :note, :finished, :unfinished, :customer)
      product.attributes = parameters.permit(:location, :item_type, :picnum, :oldpicnum, :note, :finished, :unfinished, :customer)
      
      #Float('1.0') => 1.0  , but Float('a1.0') => raise erorr, so we need to rescue that.
      if (Float(product.finished) rescue false) then
        product.finished = product.finished.to_i.to_s
      end
      
      if (Float(product.unfinished) rescue false) then
        product.unfinished = product.unfinished.to_i.to_s
      end

      invalidProductNum += 1 if !product.save
    end
    return invalidProductNum
  end

  def self.export(options = {})
    CSV.generate(options) do |csv|
      export_column_names = ["id", "location", "item_type", "picnum", "oldpicnum", "note", "finished", "unfinished", "customer"]
      csv << export_column_names
      self.all.each do |product|
        csv << product.attributes.values_at(*export_column_names)
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
