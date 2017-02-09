require './lib/person'

class Bank
  attr_reader :bank_name, :account_holder
  attr_accessor :total_amount

  def initialize(name)
    @bank_name = name
    @total_amount = 0
    puts "#{bank_name} has been created."
  end

  def open_account(person)
    person.bank_accounts[bank_name] = 0
    puts "An account has been opened for #{person.person_name} with #{bank_name}."
  end

  def deposit(person, amount)
    if amount > person.cash
      puts "#{person.person_name} does not have enough cash to perform this deposit."
    else
      person.cash -= amount
      person.bank_accounts[bank_name] += amount
      require "pry"; binding.pry
      @total_amount += amount
      puts "#{amount} galleons have been deposited into #{person.person_name}'s Chase account. Balance: #{person.bank_accounts[bank_name]} Cash: #{person.cash} "
    end
  end

  def withdrawal(person, amount)
    if amount > person.bank_accounts[bank_name]
      puts "Insufficient funds"
    else
      person.cash += amount
      person.bank_accounts[bank_name] -= amount
      @total_amount -= amount
      puts "#{person.person_name} has withdrawn #{amount} galeons. Balance: #{person.bank_accounts[bank_name]}"
    end
  end

  def transfer(person, bank2, amount)
    if person.bank_accounts[bank2.bank_name] == nil
      puts "#{person.person_name} does not have an account with #{bank2.bank_name}."
    else
      if amount > person.bank_accounts[bank_name]
        puts "Insufficient funds"
      else
        person.bank_accounts[bank_name] -= amount
        @total_amount -= amount
        person.bank_accounts[bank2.bank_name] += amount
        bank2.total_amount += amount
        puts "#{person.person_name} has transferred #{amount} galleons from #{bank_name} to #{bank2.bank_name}."
      end
    end
  end

  def total_cash
    puts "Total Cash:#{total_amount}"
  end
end

person1 = Person.new("Minerva", 1000)

person2 = Person.new("Luna", 500)

chase = Bank.new("JP Morgan Chase")

wells_fargo = Bank.new("Wells Fargo")

chase.open_account(person1)
chase.deposit(person1, 750)
chase.withdrawal(person1, 150)
wells_fargo.open_account(person1)
chase.transfer(person1, wells_fargo, 250)
chase.open_account(person2)
chase.deposit(person1, 130)
wells_fargo.total_cash
chase.total_cash
require "pry"; binding.pry
puts ""
