require 'csv'
class CreatePayments < ActiveRecord::Migration[5.2]
  def change

    create_table :payments
    add_column :payments, :year, :integer
    add_column :payments, :month, :integer
    add_column :payments, :country, :string
    add_column :payments, :order_id, :integer
    add_column :payments, :customer_id, :integer
    add_column :payments, :revenue, :float

    payment = Payment.new
    payment.order_id = 536365
    date = Date.parse("2010-12-01 08:26:00")
    payment.year = 2010
    payment.month = 12
    payment.country = "United Kingdom"
    payment.customer_id = 17850
    revenue = 0.0
    pays_array = []
    csv_options = {headers: true, header_converters: :symbol}
    CSV.foreach(Rails.root.join('db/csv_file.csv'), csv_options) do |row|
      if payment.order_id != row[:order_id].to_i
        payment.revenue = revenue
        payment.save
        payment = Payment.new
        date = Date.parse(row[:date])
        payment.year = date.year
        payment.month = date.month
        payment.order_id = row[:order_id].to_i
        payment.customer_id = row[:customer_id].to_i
        payment.country = row[:country]
        revenue = row[:quantity].to_f * row[:unit_price].to_f
        pays_array.push(row[:country])
      elsif
        revenue += row[:quantity].to_f * row[:unit_price].to_f
      end
    end
    payment.revenue = revenue
    payment.save
  end
end
