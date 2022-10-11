require "employee"

class Startup
    attr_accessor :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        if @salaries.keys.any?(title)
            return true
        else
            return false
        end
    end

    def >(other_startup)
        if self.funding > other_startup.funding
            return true
        else
            return false
        end
    end

    def hire(name, title)
        if !@salaries.keys.any?(title)
            raise ArgumentError.new 'error - title is invalid'
        else
            @employees << Employee.new(name, title)
        end 
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding - @salaries[employee.title] > 0
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise 'error - not enough funding'
        end
    end

    def payday
        @employees.each { |employee| pay_employee(employee) }
    end

    def average_salary
        total_salaries = 0
        @employees.each do |employee|
            total_salaries += salaries[employee.title]
        end
        total_salaries / (@employees.length * 1.0)
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(other_startup)
        @funding += other_startup.funding
        other_startup.salaries.each do |title, salary|
            if !@salaries.keys.include?(title)
            #     @salaries[title + "- b"] = salary
            # else
                @salaries[title] = salary
            end
        end
        other_startup.employees.each { |employee| @employees << employee }  
        other_startup.close  
    end

end
