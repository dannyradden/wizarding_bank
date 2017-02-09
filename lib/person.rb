class Person
attr_reader :person_name
attr_accessor :bank_accounts, :cash
  def initialize(name, cash)
    @person_name = name
    @cash = cash
    puts "#{person_name} has been created with #{cash} galleons in cash."
    @bank_accounts = {}
  end
end
