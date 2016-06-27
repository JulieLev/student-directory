require 'csv'

@students = [] # an empty array accessible to all methods
@file = "students.csv" # default name of the currently selected file

def initial_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil?
    if File.exist?(@file)
      filename = @file
      load_students_csv
      puts "Loaded #{@students.count} from #{@file}"
    else # if it doesn't exist
      puts "Sorry, #{filename} doesn't exist."
      exit # quit the program
    end
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to #{@file} file"
  puts "4. Load the list from #{@file} file"
  puts "5. Choose a file to load"
  puts "9. Exit" # 9 because we'll be adding more items
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
    when "5"
      choose_file
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def input_students
  puts "You are currently linked to #{@file}."
  puts "Please enter the names of the students:"
  puts "To finish, or to cancel and change the file first, just hit return twice."
  # create an empty array
  # students = []
  # get the first name
  # name = gets.gsub(/\n/,”")
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
      # check for typos
      if months.include?(cohortlabel)
        m = true
      # check if empty
      elsif cohortlabel.empty?
        cohortlabel = "Unknown"
        m = true
      else
        puts "Please enter a valid month:"
      end # end if
    end # end second while

    cohortlabel = cohortlabel.to_sym

    # add the student hash to the array (simple version for later exercises)
    # @students << {name: name, cohort: cohortlabel, hobbies:[],
      # country:"Not known", height_m: "Not known"}
    @students << { name: name, cohort: cohortlabel}

    if @students.count == 1
      puts "Now we have #{@students.count} student."
    else
      puts "Now we have #{@students.count} students."
    end # end if

    puts "Please enter the name of the next student or hit Return twice to finish."
    # get another name from the user
    name = STDIN.gets.chomp  # gets.gsub(/\n/,”")
  end # end first while

  puts "Would you like to save these students to the file now? Please enter Y or N."
  r = gets.chomp.upcase
  if r == "Y"
    save_students
  else
    puts "The students were not saved to the file."
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The Students of Villains Academy".center(40)
  puts "-------------".center(40)
end

def print_students_list
  count = @students.count
  if count == 0
    puts "There are no students to print.".center(40)
    puts # line spacer
    interactive_menu
  else

  n = 1
  while n <= count
  @students.map do |student|
    name = student[:name]
    cohortstr = student[:cohort].to_s.capitalize
    puts "#{n.to_s.center(4)} #{name.ljust(30)} #{cohortstr}"
    n += 1
  end # end of map do
  end # end of while
  puts # spacer line
  end # end if
end # end of print

def print_footer
  if @students.count == 1
    puts "Overall we have #{@students.count} great student.".center(40)
  else
    puts "Overall we have #{@students.count} great students.".center(40)
  end
  puts # spacer line
end

def save_students
  if @students.empty?
    puts "There are no outstanding students to add."
    return
  end
  # open the file for writing
  puts "You are currently linked to #{@file}."
  puts "Is this correct? Enter Y if so or N to change the file."
  r = gets.chomp.upcase
  if r == "N"
    choose_file
  end

  File.open(@file, "w") do |file|
    # iterate over the array of students
    @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
    end # end student do
  end # file open do

  if File.exists?(@file)
    puts "The students have been saved to the file #{@file}."
  else
    "The save was not successful - the file does not exist."
  end

end # end save_students

def load_students
  @students = []
  File.open(@file, "r") do |file|
    file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << { name: name, cohort: cohort.to_sym}
    end # end do
  end # end file.open
puts "The current file is #{@file}."
end # end load students

def load_students_csv
  @students = []
  CSV.foreach(@file) do |row|
    name = row[0]; cohort = row[1]
    @students << { name: name, cohort: cohort.to_sym}
    end # end do
  puts "The current file is #{@file}."
  puts @students
  puts
  CSV.foreach('students.csv') do |row|
  puts row.inspect
  end
end # end load_students_csv

def choose_file
  puts "Please enter the name of the file you wish to use:"
  filenew = gets.chomp.downcase
  if File.exist?(filenew)
    @file = filenew
    load_students
    puts "The current file is #{@file}."
  else
    puts "Sorry, I can't find that file."
  end
end


# *** Older methods not currently called ***

# print the students from a specific cohort.
def cohorts_print
  puts 'Students grouped by cohort:'
  puts # spacer line
  existing_cohorts = []
  existing_cohorts = @students.map { |student| student[:cohort]}.sort.uniq
   for i in (0..existing_cohorts.length-1)
     @students.map do |student|
        if student[:cohort] == existing_cohorts[i]
          cohortstr = student[:cohort].to_s.capitalize + " Cohort"
          puts "#{cohortstr.ljust(20)} #{student[:name]} "
        end # end if
      end # end do
   end # end for
  # cohorts
end # end default

# to print list of students whose names are < 12 characters
def print_less_than_12
  puts "Students with names shorter than 12 characters are:"
  @students.map do |student|
    name = student[:name]
    cohortstr = student[:cohort].to_s.capitalize

  # if name is shorter than 12 characters
    if name.length <12
      puts "#{name.ljust(30)} #{cohortstr}"
    end
    end # end of do
  puts # spacer line
end # end of print_less_than_12

# to print students whose names begin with an input letter
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
     end # end of if
    end # end of do
  puts # to print spacer line
end # end of print_letter

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


initial_load_students
interactive_menu
#students = input_students
#print_header
#print(students)
#print_footer(students)
#print_letter(students)
#print_less_than_12(students)
#cohorts_print students
