class Item < ActiveRecord::Base
  before_save :setDefaultValue
  validates :picnum, presence: true

  def setDefaultValue
    self.finishQty ||= 0
    self.unfinishQty ||= 0
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
      where("location like ? OR item_type like ? OR picnum like ? OR oldpicnum like ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  end

  def self.import(file)
    invalidProductNum = 0
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      product.attributes = parameters.permit(:location, :item_type, :picnum, :oldpicnum, :note, :finishQty, :unfinishQty)
      invalidProductNum += 1 if !product.save
    end
    return invalidProductNum
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
