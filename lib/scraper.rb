require_relative '../config.rb'
require 'open-uri'
require 'pry'

class Scraper
  BASE_PATH = "./fixtures/student-site/"

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css('div.student-card')
    students_info = []

    student_cards.each do |student_card|
      student = {}
      student[:name] = student_card.css('.student-name').text
      student[:location] = student_card.css('.student-location').text
      student[:profile_url] = student_card.css('a:first').attr('href').text

      students_info << student
    end

    students_info
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile_info = {}
    profile_info[:twitter] = doc.css('a[href*="twitter.com"]').attr("href").text unless doc.css('a[href*="twitter.com"]').empty?
    profile_info[:linkedin] = doc.css('a[href*="linkedin.com"]').attr("href").text unless doc.css('a[href*="linkedin.com"]').empty?
    profile_info[:github] = doc.css('a[href*="github.com"]').attr("href").text unless doc.css('a[href*="github.com"]').empty?
    profile_info[:profile_quote] = doc.css('.profile-quote').text
    profile_info[:bio] = doc.css('.bio-content p').text

    finding_blog = doc.css('.social-icon-container a:last').attr("href").text
    unless finding_blog.include?("linkedin") || finding_blog.include?("github") || finding_blog.include?("twitter")
      profile_info[:blog] = doc.css('.social-icon-container a:last').attr("href").text
    end

    profile_info
  end
end

# puts Scraper.scrape_index_page "./fixtures/student-site/index.html"
# puts Scraper.scrape_profile_page "./fixtures/student-site/students/john-anthony.html"
puts Scraper.scrape_profile_page "./fixtures/student-site/students/joe-burgess.html"
