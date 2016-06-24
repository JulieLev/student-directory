
def input_students
  puts "Please enter the names of the students:"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november, hobbies:[], country:"Not known", height_m: "Not known"}
    puts "Now we have #{students.count} students"
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
  #only = students.select {|k,v| v.to_s.start_with?("B")}
  students.each_with_index do |student, i|
    n = i + 1
    name = student[:name].capitalize
    cohortstr = student[:cohort].to_s.capitalize.center(10)
  # if name starts with b...
    #if name.downcase.start_with?("b")
    #  puts "#{n} #{name} (#{cohort} cohort)"
    #end
  #if name is shorter than 12 characters
    #if name.length <12
    #  puts "#{n} #{name} (#{cohort} cohort)"
    #end
    puts "#{n} #{name.center(30)} #{cohortstr}"
    end #end of each
end #end of print

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
