class Item < ActiveRecord::Base

    def self.multiSearch(queries)
        queries = queries.strip.split(/\s+/)
        querySQL = ""
        queries.each do |query|
            if querySQL.blank? then
                querySQL = where("location like ? OR item_type like ? OR picnum like ?", "%#{query}%", "%#{query}%", "%#{query}%")
            else
                querySQL = querySQL + where("location like ? OR item_type like ? OR picnum like ?", "%#{query}%", "%#{query}%", "%#{query}%")
            end
        end
        return querySQL
    end
    def self.search(query)
        where("location like ? OR item_type like ? OR picnum like ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end
end
