# -*- encoding : utf-8 -*-
module TextParser
  # Returns a parsed text with the words and its occurrences.
  # @param [Hash] [args]
  # [args] [Symbol] :dictionary, :order, :order_direction, :negative_dictionary
  # @return [Array of Hash]  
  def parse(args = {})
    args.delete_if {|key, value| value.nil? }
    options = {
      :order => :word,
      :order_direction => :asc,
      :negative_dictionary => []
    }.merge(args)
    result = []
    text = self.gsub(/[^A-Za-zÀ-ú0-9\-]/u," ").strip
    options[:dictionary] = text.split(" ") unless options[:dictionary]
    return [] if options[:dictionary].count < 1
    regex = Regexp.new(options[:dictionary].join('\\b|\\b'), Regexp::IGNORECASE)
    match_result = text.scan(regex).map{|i| i.downcase}   
    match_result.each do |w|
      result << {:hits => match_result.count(w), :word => w} unless result.select{|r| r[:word] == w}.shift || options[:negative_dictionary].map{|i| i.downcase}.include?(w)
    end 
    result = result.sort_by{|i| i[options[:order]]}
    result.reverse! if options[:order_direction] == :desc
    result
  end
end

# Includes module TextParser in the String object
class String
  include TextParser
end
