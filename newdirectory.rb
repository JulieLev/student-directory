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

    if students.count == 1
      puts "Now we have #{students.count} student."
    else
      puts "Now we have #{students.count} students."
    end #end if

    puts "Please enter the name of the next one or hit Return twice to finish."
    # get another name from the user
    name = gets.chomp  #gets.gsub(/\n/,”")
 end #end first while
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(70)
  puts "-------------".center(70)
end

def print(students)
  n = 1
  count = students.count
  while n <= count
    students.map do |student|
      name = student[:name]
      cohortstr = student[:cohort].to_s.capitalize
      puts "#{n.to_s.center(4)} #{name.ljust(30)} #{cohortstr}"
      end #end of map do
    n += 1
  end #end of while
end #end of print

def print_footer(names)
  if students.count == 1
   puts "Overall we have #{students.count} great student."
  else
   puts "Overall we have #{students.count} great students."
  end
end

=begin
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
=end
=begin
def print_letter(students)
  n = 1
  count = students.count
  while n <= count
    students.map do |student|
      name = student[:name]
      cohortstr = student[:cohort].to_s.capitalize
      #if name starts with...
      puts "Please enter a letter to select students' names:"
      l = gets.chomp
      puts "Students whose names beginning with #{l} are:"
      if name.downcase.start_with?(l)
        puts "#{n.to_s.center(4)} #{name.ljust(30)} #{cohortstr}"
      end #end of if
    end #end of do
  n += 1
  end #end of while
  puts
end #end of print_letter
=end
=begin
def print_less_than_12(students)
  n = 1
  count = students.count
  while n <= count
    students.map do |student|
    name = student[:name]
    cohortstr = student[:cohort].to_s.capitalize

  #if name is shorter than 12 characters
    if name.length <12
      puts "#{n} #{name} #{cohortstr}"
    end
    end #end of do
  n += 1
  end #end of while
  puts
end #end of print_less_than_12
=end
=begin
#print the students from a specific cohort.
existing_cohorts = []
​def cohorts students, existing_cohorts
  existing_cohorts = students.map {|student| student[:cohort]}.sort.uniq
   for i in (0..existing_cohorts.length-1)
      students.map do |student|
        if student[:cohort] == existing_cohorts[i]
          puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(70)
        end #end if
      end #end do
   end #end for
end #end def
=end



students = input_students
print_header
print(students)
#print_cohorts #students existing_students
#print_by_cohort (students)
print_footer(students)
#print_letter(students)
#print_less_than_12(students)
#puts cohorts
