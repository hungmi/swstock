class Item < ActiveRecord::Base
  before_save :setDefaultValue
  validates :picnum, presence: true
  validates :location, presence: true

  class << self

    def search(query)
      where("lower(location) like ? OR lower(item_type) like ? OR lower(picnum) like ? OR lower(oldpicnum) like ?", ("%#{query}%").downcase, ("%#{query}%").downcase, ("%#{query}%").downcase, ("%#{query}%").downcase)
    end

    def import(file)
      invalid_product_num = 0
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
        
        product.finished = product.finished.to_i.to_s if is_number?(product.finished)
        product.unfinished = product.unfinished.to_i.to_s if is_number?(product.unfinished)

        invalid_product_num += 1 if !product.save
      end
      return invalid_product_num
    end

    def is_number?(string)
      Float(string) rescue false
    end

    def export(options = {})
      CSV.generate(options) do |csv|
        export_column_names = ["id", "location", "item_type", "picnum", "oldpicnum", "note", "finished", "unfinished", "customer"]
        csv << export_column_names
        self.all.each do |product|
          csv << product.attributes.values_at(*export_column_names)
        end
      end
    end

    def open_spreadsheet(file)
      case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end

  end

  # end of self method class

  def setDefaultValue
    self.finished ||= '0'
    self.unfinished ||= '0'
  end

end
