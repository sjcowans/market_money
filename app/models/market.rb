# frozen_string_literal: true

class Market < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :county
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :lat
  validates_presence_of :lon

  has_many :market_vendors, dependent: :destroy
  has_many :vendors, through: :market_vendors

  def self.search(params)
    searches = params.except(:markets_search)
    markets = self
    if param_check(params) == true
      searches.each do |attribute, search| 
        markets = where("lower(#{attribute}) = ?", "#{search}".downcase)
      end
      markets
    else
      "invalid"
    end
  end

  def self.param_check(params)
    if params[:state].nil? && !params[:city].nil? || params[:state].nil? && !params[:name].nil?
      false
    else 
      true
    end
  end
end
