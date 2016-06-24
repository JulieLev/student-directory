
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
    puts "Which cohort does #{name} belong to? Please enter the full month name e.g. November"
    cohortlabel = gets.chomp.to_sym

    # add the student hash to the array
    students << {name: name, cohort: cohortlabel, hobbies:[], country:"Not known", height_m: "Not known"}
    puts "Now we have #{students.count} students."
    puts "Please enter the name of the next one or hit Return twice to finish."
    # get another name from the user
    name = gets.chomp
  end
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
    students.map do |student|
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

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
