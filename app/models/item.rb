class Item < ActiveRecord::Base
  scope :recent, -> { order(updated_at: :desc) }
  scope :paginated, -> (page) { paginate(:per_page => 20, :page => page) }

  validates :picnum, presence: true
  validates :location, presence: true

  include ExcelAccesor

  def customer_color
  	return Customer.find_by_name(self.customer).try(:color)
  end

  def clipboard_picnum
  	result = self.picnum#.gsub("+","")
  	first = self.location
    names = []
    picnums = []
    result.split("+").each do |name_and_picnum|
      picnum = name_and_picnum[/[0-9]{4,}/]
      picnums << picnum
      names << name_and_picnum.gsub(picnum, "").to_s
    end
    if names.size == 1 && picnums.size == 1
      return result = first + "\t\"" + names.join("\r\n\"") + "\t\"\t\"" + picnums.join("\r\n\"")
    elsif names.size == 3 && picnums.size == 3 # 會有問題～但這是 google 的 bug，他只能給斷一行，兩行以上斷不了
      return result = first + "\t\"" + names.join("\r\n\"") + "\t\"\t\"" + picnums.join("\r\n\"")
    else
      return result = first + "\t\"" + names.join("\r\n\"") + "\t\"" + picnums.join("\r\n\"")
    end
   #  picnums = self.picnum.scan(/[0-9]{4,}/)
   #  picnums.each do |ps|
   #    result = result.gsub(ps, "")
   #  end
   #  item_result.split("+")
  	# second = result.scan(/[0-9]{0,3}[.][0-9]{0,3}\D+/).join("\r\n\"") #.scan(/[0-9]+.[0-9]+\D+/).join("\r\n\"")
  	# third = result.scan(/[0-9]+{4,}/).join("\r\n\"") #.scan(/[0-9]+.[0-9]+/).join("\r\n\"")
   #  binding.pry
  	# return result = first + "\t\"" + second + "\t\"" + third
  end

end
