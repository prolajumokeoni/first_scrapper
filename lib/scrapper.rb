# frozen_string_literal: true

require 'httparty'
require 'nokogiri'
# disable top-level class documentation commment
class Scraper
  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get('https://www.nike.com/za/w/mens-shoes-nik1zy7ok')
    @parse_page ||= Nokogiri::HTML(doc.body)
  end

  def shoe_names
    parse_page.css('.product-card__title').children.map(&:text).compact
  end

  def shoe_prices
    parse_page.css('.product-card__price').children.map(&:text).compact
  end

  scraper = Scraper.new
  names = scraper.shoe_names
  prices = scraper.shoe_prices

  (0...prices.size).each do |index|
    puts "--- index: #{index + 1} ---"
    puts "Name:#{names[index]} | price: #{prices[index]}"
  end
end
