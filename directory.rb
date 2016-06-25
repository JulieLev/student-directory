
@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students:"
  puts "To finish, just hit return twice."
  # create an empty array
  #students = []
  # get the first name
  #name = gets.gsub(/\n/,”")
  name = STDIN.gets.chomp
      # while the name is not empty, repeat this code
  while !name.empty? do
    # get the cohort
    m = false
    while m == false
      puts "Which cohort does #{name} belong to? Please enter the month name."
      cohortlabel = STDIN.gets.chomp
      months = ["january", "february", "march", "april", "may", "june",
        "july", "august", "september", "october", "november", "december"]
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

    # add the student hash to the array (simple version for later exercises)
    #@students << {name: name, cohort: cohortlabel, hobbies:[],
      #country:"Not known", height_m: "Not known"}
    @students << {name: name, cohort: cohortlabel}

    if @students.count == 1
      puts "Now we have #{@students.count} student."
    else
      puts "Now we have #{@students.count} students."
    end #end if

    puts "Please enter the name of the next one or hit Return twice to finish."
    # get another name from the user
    name = STDIN.gets.chomp  #gets.gsub(/\n/,”")
  end #end first while
  # return the array of students
  #return students
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def print_header
  puts "The Students of Villains Academy".center(40)
  puts "-------------".center(40)
end

def print_students_list
  count = @students.count
  if count ==0
    puts "There are no students to print.".center(40)
    exit
  else

  n = 1
  while n < count
  @students.map do |student|
      name = student[:name]
      cohortstr = student[:cohort].to_s.capitalize
      puts "#{n.to_s.center(4)} #{name.ljust(30)} #{cohortstr}"
      n +=1
      end #end of map do
  end #end of while
puts #spacer line
  end #end if
end #end of print

def print_footer
  if @students.count == 1
   puts "Overall we have #{@students.count} great student.".center(40)
  else
   puts "Overall we have #{@students.count} great students.".center(40)
  end
  puts # spacer line
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

#to print students whose names begin with an input letter
def print_letter
    puts "Please enter a letter to select students' names:"
    l = gets.chomp

    @students.each do |student|
    name = student[:name]
    cohortstr = student[:cohort].to_s.capitalize
    #if name starts with...
     if name.downcase.start_with?(l)
      puts "Students whose names beginning with #{l} are:"
      puts "#{name.ljust(30)} #{cohortstr}"
     end #end of if
    end #end of do
  puts #to print spacer line
end #end of print_letter

#to print list of students whose names are < 12 characters
def print_less_than_12
  puts "Students with names shorter than 12 characters are:"
  @students.map do |student|
    name = student[:name]
    cohortstr = student[:cohort].to_s.capitalize

  #if name is shorter than 12 characters
    if name.length <12
      puts "#{name.ljust(30)} #{cohortstr}"
    end
    end #end of do
  puts #spacer line
end #end of print_less_than_12

#print the students from a specific cohort.
def cohorts_print #students #, existing_cohorts
  puts "Students grouped by cohort:"
  puts #spacer line
  existing_cohorts = []
  existing_cohorts = @students.map {|student| student[:cohort]}.sort.uniq
   for i in (0..existing_cohorts.length-1)
      @students.map do |student|
        if student[:cohort] == existing_cohorts[i]
          cohortstr = student[:cohort].to_s.capitalize + " Cohort"
          puts "#{cohortstr.ljust(20)} #{student[:name]} "
        end #end if
      end #end do
   end #end for
  #cohorts
end #end def

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv file"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_students_list
  print_footer
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

try_load_students
interactive_menu
#students = input_students
#print_header
#print(students)
#print_footer(students)
#print_letter(students)
#print_less_than_12(students)
#cohorts_print students
