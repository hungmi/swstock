module ExcelAccesor
  extend ActiveSupport::Concern

  module ClassMethods

    def import_sourcing(file)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        parameters = ActionController::Parameters.new(row.to_hash)
        next if parameters[:factory_name].include?('製程')
        # w = first || second, w will = first if first is executable
        workpiece = Workpiece.find_by_picnum(parameters[:picnum].to_s.strip) || Workpiece.new
        unless workpiece.persisted?
          workpiece.attributes = parameters.permit(:wp_type, :picnum, :spec)
          workpiece.picnum = workpiece.picnum.to_s.strip
          workpiece.save
        end

        procedure = workpiece.procedures.find_by_start_date(parameters[:start_date].to_date) || workpiece.procedures.new
        unless procedure.persisted?
          procedure.attributes = parameters.permit(:sourcing_type, :start_date, :customer, :material_spec, :procedure_amount)
          procedure.save
        end

        stage = procedure.stages.new
        stage.attributes = parameters.permit(:factory_name, :arrival_amount, :arrival_date, :estimated_date, :note, :finished_date, :finished_amount, :broken_amount)
        stage.save

        if parameters[:material_spec].present? && parameters[:material_spec].include?('實')
          stage.procedure.workpiece.update_column(:spec, parameters[:material_spec]) if stage.procedure.workpiece.spec.blank?
        end
      end

      Procedure.find_each do |p|
        #p.finish! if p.stages.last.finished?
        p.stages.find_each do |s|
          s.update_status_after_import
        end
      end
      #Procedure.all.update_all(start_date: start_date.to_date)
      #self.procedure.finish! unless self.next
    end

    def import_stock(file)
      invalid_product_num = 0
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        product = find_by_id(row["id"]) || new
        parameters = ActionController::Parameters.new(row.to_hash)
        #之後要匯入ID的話要修改這邊
        product.attributes = parameters.permit(:id, :location, :item_type, :picnum, :oldpicnum, :note, :finished, :unfinished, :customer)
        
        #Float('1.0') => 1.0  , but Float('a1.0') => raise erorr, so we need to rescue that.
        
        product.picnum = is_number?(product.picnum)
        product.oldpicnum = is_number?(product.oldpicnum)
        product.finished = is_number?(product.finished)
        product.unfinished = is_number?(product.unfinished)

        invalid_product_num += 1 if !product.save
      end
      return invalid_product_num
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

    def is_number?(string)
      string.to_i.to_s if Float(string) rescue string
    end

  end
  
end