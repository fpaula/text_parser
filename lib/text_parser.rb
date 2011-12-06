module TextParser
  # Returns a parsed text with the words and its occurrences.
  # @param [Hash] [args]
  # [args] [Symbol] :dictionary, :order, :order_direction, :negative_dictionary
  # @return [Array of Hash]  
  def parse(args = {})
    options = {
      :dictionary => nil,
      :order => :word,
      :order_direction => :asc,
      :negative_dictionary => []
    }.merge(args)
    result = []
    text = process_text
    options[:dictionary] = text.split(" ") unless options[:dictionary]
    return [] if options[:dictionary].count < 1
    regex = Regexp.new(options[:dictionary].join("|"), Regexp::IGNORECASE)
    match_result = text.scan(regex).map{|i| i.downcase}
    match_result.each do |w|
      result << {:hits => match_result.count(w), :word => w} unless result.select{|r| r[:word] == w}.shift unless options[:negative_dictionary].map{|i| i.downcase}.include?(w)
    end 
    result = result.sort_by{|i| i[options[:order]]}
    result.reverse! if options[:order_direction] == :desc
    result
  end
  
  private
  
  def process_text
    self.gsub(/[^\w\s\-]/, "")
  end
end

# Includes module TextParser in the String object
class String
  include TextParser
end