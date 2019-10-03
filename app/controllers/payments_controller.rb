class PaymentsController < ApplicationController
skip_before_action :verify_authenticity_token

  @@db = Payment.all # variable de classe, qui ne disparait pas quand on quitte une méthode
  @@answer_form = "All" # pour conserver la réponse du formulaire

  def index
    puts "index"
    puts @@answer_form
    @countries = @@db.select(:country).map(&:country).uniq #select all unique countries in the db
    @countries.push("All") #user can select "all" in the dropdown
    if @@answer_form == "All"#case if user choose all
       @country = "All"
       pays_db = @@db# all db (Payment.all)
    else
       @country = @@answer_form #or the user choose only one country
       pays_db = @@db.where(country:@country)
    end

    @revenue = pays_db.select(:revenue).map(&:revenue).sum #total revenue
    @revenueaverage = pays_db.select(:revenue).map(&:revenue).sum/pays_db.length #revenue average
    @customer = pays_db.select(:customer_id).map(&:customer_id).uniq.length #number of customers
    months_array = [12,1,2,3,4,5,6,7,8,9,10,11,12]
    years_array = [2010,2011,2011,2011,2011,2011,2011,2011,2011,2011,2011,2011,2011]
    months_revenues = []
    (0..12).each do |n|
      month = months_array[n] #iterate on each month/year
      year = years_array[n]
      month_year = month.to_s + "/" + year.to_s
      month_db = pays_db.where(month:month).where(year:year)
      months_revenue = month_db.select(:revenue).map(&:revenue).sum
      months_revenues.push([month_year, months_revenue])
    end
    @m = months_revenues
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def new
    @payment = Payment.new(params[:country])
    @payment.save
  end

  def create
    #Payment.create(params[:payment])
    @@answer_form = params[:country]
    puts @@answer_form
    redirect_to "/payments" #link to payments
  end
end
