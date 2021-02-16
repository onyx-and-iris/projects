class Donation
    """ define reader/write methods and intialize them """
    attr_reader :name, :amount

    def name=(value)
        if value.empty?
            puts "Error: name cannot be empty!"
        end
        @name = value
    end

    def amount=(value)
        if value.empty?
            puts "Error: amount cannot be empty!"
        end
        @amount = value
    end

    def initialize(name = "Anonymous", amount = "0.00")
        self.name = name
        self.amount = amount
    end

    def announce
        puts "#{self.name} just donated $#{self.amount}! Thanks so much =)"
    end
end

# expect default values
default_values = Donation.new
default_values.announce

# throw errors
test = Donation.new('', '')

# full functional
jon_daDon = Donation.new('jon_daDon', '3.00')
jon_daDon.announce