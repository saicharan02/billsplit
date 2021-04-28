class Bill < ApplicationRecord

    validates :name, :amount, presence: :true
  
    belongs_to :user
  
    has_many :guests, dependent: :destroy
  
    has_many :debts, dependent: :destroy
  
  
    def self.calculate(bill_id, bill_total, guests_params)
      guests_array = []
      
      guests_params.each do |guest|
        if guest.has_key?("money_to_pay")
            new_guest = Player.new(guest[:name], guest[:money_paid].to_f, guest[:money_to_pay].to_f)
            Guest.create(:name => guest[:name], :bill_id => bill_id, :money_paid => guest[:money_paid].to_f, :money_to_pay => guest[:money_to_pay].to_f)
        else
            money_to_pay = bill_total / guests_params.length.to_f
          new_guest = Player.new(guest[:name], guest[:money_paid].to_f, money_to_pay)
            Guest.create(:name => guest[:name], :bill_id => bill_id, :money_paid => guest[:money_paid].to_f, :money_to_pay => money_to_pay)
          end
        guests_array.push(new_guest)
      end
  
      guests_who_overpaid = []
      guests_who_underpaid = []
  
      guests_array.each do |guest|
        guests_who_overpaid.push(guest) if guest.bill_difference > 0
        guests_who_underpaid.push(guest) if guest.bill_difference < 0
      end
  
      debts_count = 0
  
      total_from_debtors = 0
  
      guests_who_underpaid.each do |guest|
        total_from_debtors += guest.amount_owes
      end
  
      guests_who_underpaid.each do |u_guest|
  
        guests_who_overpaid.each do |o_guest|
          owe_to_friend = u_guest.amount_owes * (o_guest.bill_difference/total_from_debtors.to_f)
          Debt.create(:bill_id => bill_id, :debtor_name => u_guest.name, :creditor_name => o_guest.name, :amount => owe_to_friend)
          debts_count += 1
        end
          end
  
          "#{debts_count} debts created for this bill."
      end
  
    def self.correct_input(bill_total, guests_params)
      guests_payment = 0
  
      guests_params.each do |guest|
        guests_payment += guest[:amount_paid].to_f
      end
  
      guests_payment == bill_total
    end
  
  end
  
  class Player
    attr_accessor :name, :money_paid, :money_to_pay, :id
  
    def initialize(name, money_paid, money_to_pay)
      @name = name
      @money_paid = money_paid
      @money_to_pay = money_to_pay
    end
  
    def bill_difference
      @money_paid - @money_to_pay
    end
  
    def amount_owes
      @money_to_pay - @money_paid
    end
  end
  