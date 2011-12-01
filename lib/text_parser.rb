module TextParser
  def parse(dictionary = nil)
    result = []
    text = process_text
    dictionary = text.split(" ") unless dictionary
    regex = Regexp.new(dictionary.join("|"), Regexp::IGNORECASE)
    match_result = text.scan(regex).map{|i| i.downcase}
    match_result.each do |w|
      result << {:hits => match_result.count(w), :word => w} unless result.select{|r| r[:word] == w}.shift
    end 
    result
  end
  
  private
  
  def process_text
    self.gsub(/[^\w\s\-]/, "")
  end
end