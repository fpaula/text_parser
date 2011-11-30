module TextParser
  def parse(dictionary)
    result = []
    regex = Regexp.new(dictionary.join("|"))
    match_result = self.scan(regex)
    match_result.each do |w|
      result << {:hits => match_result.count(w), :word => w} unless result.select{|r| r[:word] == w}.shift
    end 
    result
  end
end