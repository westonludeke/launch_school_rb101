# ---- LOAD MESSAGES FILE ----
require 'yaml'
MESSAGES = YAML.load_file('car_loan_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  true if Float(num) rescue false
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets.chomp

  if name.empty?
    prompt("Make sure to enter a valid name.")
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  total_loan = ''
  loop do
    prompt(MESSAGES['total_loan'])
    total_loan = Kernel.gets.chomp

    if valid_number?(total_loan)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  apr_rate = ''
  loop do
    prompt(MESSAGES['apr_rate'])
    apr_rate = Kernel.gets.chomp

    if valid_number?(apr_rate)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  loan_duration_in_months = ''
  loop do
    prompt(MESSAGES['loan_duration_in_months'])
    loan_duration_in_months = Kernel.gets.chomp

    if valid_number?(loan_duration_in_months)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end
  # Calculate the API percentage rate
  apr_rate_percent = apr_rate.to_f / 100
  # Calculate the monthly interest rate
  monthly_int_rate = apr_rate_percent / 12
  prompt("Thanks! To recap: You took out a total loan of $#{total_loan}.")
  prompt("The duration of the loan is #{loan_duration_in_months} months.")
  prompt("Your API rate is #{apr_rate}%.")
  # round up monthly interest rate
  monthly_int_before = (monthly_int_rate.to_f * 100)
  # make monthly interest rate a whole percentage
  month_int = format('%2f', monthly_int_before)
  prompt("Your monthly interest rate is #{month_int}%.")
  # Calculate monthly payment amount, split onto two lines
  calc_one = (1 - (1 + monthly_int_rate.to_f)**(-loan_duration_in_months.to_f))
  monthly_payment = total_loan.to_f * (monthly_int_rate.to_f / calc_one)
  # Round up or down the monthly payment amount
  adjusted_monthly_payment = format('%.2f', monthly_payment)
  prompt("Your monthly payment is $#{adjusted_monthly_payment}.")

  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = Kernel.gets.chomp
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using the Car Loan Calculator! Good bye!")
