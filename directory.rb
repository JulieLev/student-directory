
def input_students
  puts "Please enter the names of the students:"
  puts "To finish, just hit return twice."
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
      # while the name is not empty, repeat this code
  while !name.empty? do
    # get the cohort
    m = false
    while m == false
      puts "Which cohort does #{name} belong to? Please enter the month name."
      cohortlabel = gets.chomp
      months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
      #check for typos
      if months.include?(cohortlabel)
        m = true
      #check if empty
      elsif cohortlabel.empty?
        cohortlabel = "Unknown"
        m = true
      else
        puts "Please enter a valid month: "
      end #end if
    end #end second while

    cohortlabel = cohortlabel.to_sym

    # add the student hash to the array
    students << {name: name, cohort: cohortlabel, hobbies:[], country:"Not known", height_m: "Not known"}
    puts "Now we have #{students.count} students."
    puts "Please enter the name of the next one or hit Return twice to finish."
    # get another name from the user
    name = gets.chomp
 end #end first while
  # return the array of students
  students
end


def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  n = 1
  count = students.count
 
  while n <= count
    #array.map{|x| x[:price]}
    #array.uniq { |e| e[:name] }
    #by_cohort = students.uniq{|cohort| cohort[:cohort]}
            
    name = student[:name]
    cohortstr = student[:cohort].to_s.capitalize
    
  # if name starts with b...
    #if name.downcase.start_with?("b")
    #  puts "#{n} #{name} #{cohortstr}"
    #end
  #if name is shorter than 12 characters
    #if name.length <12
    #  puts "#{n} #{name} #{cohortstr}"
    #end

    puts "#{n.to_s.center(4)} #{name.ljust(30)} #{cohortstr}"
    n += 1
      
    end #end of map
        
  end #end of while
end #end of print

def print_by_cohort(students)
    cohort_month = []
    puts "See by specific cohort month? - Enter Full Month Please"
    month = STDIN.gets.chomp.capitalize
      @students.map do |student|
        if student[:cohort] == month
          cohort_month << student
      end
    end
    print_students(cohort_month)
end  
  
def print_footer(names)
  if student.count == 1
      puts "Overall we have #{students.count} great student"
    else
      puts "Overall we have #{students.count} great students"
    end
end

students = input_students
print_header
#print(students)
print_by_cohort (students)
print_footer(students)
