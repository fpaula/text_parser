# -*- encoding : utf-8 -*-
require_relative 'text_parser/version'

module TextParser
  TEXT_PARSER_OPTIONS = {
    :order => :word,
    :order_direction => :asc,
    :order_style => :ignore_accents,
    :negative_dictionary => []
  }.freeze

  # Returns a parsed text with the words and its occurrences.
  # @param [Hash] [args]
  # [args] [Symbol] :dictionary, :order, :order_direction, :order_style, :negative_dictionary
  # @return [Array of Hash]
  def parse(args = {})
    args.delete_if { |key, value| value.nil? }
    options = TEXT_PARSER_OPTIONS.merge(args)
    text = self.gsub(/[^A-Za-zÀ-ú0-9\-]/u, ' ').strip
    options[:dictionary] = text.split(' ') unless options[:dictionary]
    return [] if options[:dictionary].count < 1
    regex = Regexp.new(options[:dictionary].join('\\b|\\b'), Regexp::IGNORECASE)
    match_result = text.scan(regex).map{|i| i.downcase}
    match_result = match_result.select{|i| i.size >= options[:minimum_length]} if options[:minimum_length]
    result = []
    match_result.each do |w|
      result << { :hits => match_result.count(w), :word => w } unless result.select { |r| r[:word] == w}.shift || options[:negative_dictionary].map{|i| i.downcase }.include?(w)
    end

    result.sort_by! do |i|
      current_item = i[options[:order]]
      ignore_accents = options[:order_style] == :ignore_accents && current_item.is_a?(String)

      ignore_accents ? current_item.without_accents : current_item
    end
    result.reverse! if options[:order_direction] == :desc

    result
  end

  def without_accents
    self.tr(
      'ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšȘșſŢţŤťŦŧȚțÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž',
      'AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSsSssTtTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz')
  end
end

# Includes module TextParser in the String object
class String
  include TextParser
end
