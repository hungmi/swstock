def comment    
end
def emphasizePicnum(items,string)
    picnums = []
    items.each do |item|
        picnums << item.picnum.scan(/[\d]{8,}/).flatten
    end
    #string = '11520'
    string = string.to_s
    #@colors = ('0'..'10').to_a
    colors = ['red','yellow','blue']
    foundTimes = 0 #計算找到欲搜尋圖號的次數，拿來換顏色用的
    puts picnums
    picnums.each_with_index do |p,index|
        p.each do |x|
            #先確定有沒有找到
            strInd = x.index(string)
             if strInd
                # puts x.to_s.index(string) # + 1 if x.to_s.index(string).presence
                strInd = strInd - x.size
                styleDetail = "<span style='color:" + colors[foundTimes] + ";font-size:30px;'>"
                #先檢查找到的位置之前還有沒有四個字元
                #如果有的話就插入，沒有的話就直接插入最前面
                x[strInd-5] ? x.insert(strInd-5, styleDetail) : x.insert(0, styleDetail)
                #經過上面的步驟，不管怎樣一定會插入，所以不用擔心前面會沒有字元
                x.insert(strInd-1,'</span>')
                puts x
                foundTimes += 1
            end
        end
    end
    return picnums
  end

  emphasizePicnum(Item.all,"11520")