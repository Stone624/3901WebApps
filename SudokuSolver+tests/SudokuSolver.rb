#create class for individual element. Element contains
#a value and a list of possibile values it could take on
class Element
	def initialize
		@value = 0
		@possibleValues=[1,2,3,4,5,6,7,8,9]
	end
	attr_reader :value, :possibleValues
	def subtractValue(i)
		if @possibleValues.include?(i)
			@possibleValues.delete(i)
		end
	end
	def writeValue(i)
		@value = i.to_i
		@possibleValues = []
	end
	def hasValue?
		@value != 0
	end
end

numberWritten=0

puts "\n\n\nHELLO, AND WELCOME TO THE AUTOMATED SUDOKU SOLVER!\n\n\n"

#open well formated text file (sudoku) and 
#read its content 
puts "Please enter a well formated sudoku file: "
fileString = gets.chomp
puts "GETTING SUDOKU FILE"
puzzle = File.open(fileString, "r") { |file| file.read }
puts "Puzzle:\n#{puzzle}"

#create 81 elements to be the 9x9 sudoku board
puts "CREATING SUDOKU BOARD"
sudokuBoard = Array.new(81)
for i in 0...81
	sudokuBoard[i] = Element.new
end

#read initial board into elements
puts "INITIALIZING SUDOKU BOARD"
a=0;
puzzle.each_char {|c|
	unless c == '|' || c == '-' || c == "\n"
		unless c=='.'
			sudokuBoard[a].writeValue(c)
			numberWritten = numberWritten+1
		end
		a = a+1
	end
}


#go through elements and hit rows, columns, and blocks
#reducing the possibilities
#TODO: turn into for loops
puts "CEATING BLOCK,ROW, AND COLUMN ARRAYS"
blocks = [[sudokuBoard[0],sudokuBoard[1],sudokuBoard[2],
sudokuBoard[9],sudokuBoard[10],sudokuBoard[11],
sudokuBoard[18],sudokuBoard[19],sudokuBoard[20]],
[sudokuBoard[3],sudokuBoard[4],sudokuBoard[5],
sudokuBoard[12],sudokuBoard[13],sudokuBoard[14],
sudokuBoard[21],sudokuBoard[22],sudokuBoard[23]],
[sudokuBoard[6],sudokuBoard[7],sudokuBoard[8],
sudokuBoard[15],sudokuBoard[16],sudokuBoard[17],
sudokuBoard[24],sudokuBoard[25],sudokuBoard[26]],
[sudokuBoard[27],sudokuBoard[28],sudokuBoard[29],
sudokuBoard[36],sudokuBoard[37],sudokuBoard[38],
sudokuBoard[45],sudokuBoard[46],sudokuBoard[47]],
[sudokuBoard[30],sudokuBoard[31],sudokuBoard[32],
sudokuBoard[39],sudokuBoard[40],sudokuBoard[41],
sudokuBoard[48],sudokuBoard[49],sudokuBoard[50]],
[sudokuBoard[33],sudokuBoard[34],sudokuBoard[35],
sudokuBoard[42],sudokuBoard[43],sudokuBoard[44],
sudokuBoard[51],sudokuBoard[52],sudokuBoard[53]],
[sudokuBoard[54],sudokuBoard[55],sudokuBoard[56],
sudokuBoard[63],sudokuBoard[64],sudokuBoard[65],
sudokuBoard[72],sudokuBoard[73],sudokuBoard[74]],
[sudokuBoard[57],sudokuBoard[58],sudokuBoard[59],
sudokuBoard[66],sudokuBoard[67],sudokuBoard[68],
sudokuBoard[75],sudokuBoard[76],sudokuBoard[77]],
[sudokuBoard[60],sudokuBoard[61],sudokuBoard[62],
sudokuBoard[69],sudokuBoard[70],sudokuBoard[71],
sudokuBoard[78],sudokuBoard[79],sudokuBoard[80]]]

rows = [[sudokuBoard[0],sudokuBoard[1],sudokuBoard[2],
sudokuBoard[3],sudokuBoard[4],sudokuBoard[5],
sudokuBoard[6],sudokuBoard[7],sudokuBoard[8]],
[sudokuBoard[9],sudokuBoard[10],sudokuBoard[11],
sudokuBoard[12],sudokuBoard[13],sudokuBoard[14],
sudokuBoard[15],sudokuBoard[16],sudokuBoard[17]],
[sudokuBoard[18],sudokuBoard[19],sudokuBoard[20],
sudokuBoard[21],sudokuBoard[22],sudokuBoard[23],
sudokuBoard[24],sudokuBoard[25],sudokuBoard[26]],
[sudokuBoard[27],sudokuBoard[28],sudokuBoard[29],
sudokuBoard[30],sudokuBoard[31],sudokuBoard[32],
sudokuBoard[33],sudokuBoard[34],sudokuBoard[35]],
[sudokuBoard[36],sudokuBoard[37],sudokuBoard[38],
sudokuBoard[39],sudokuBoard[40],sudokuBoard[41],
sudokuBoard[42],sudokuBoard[43],sudokuBoard[44]],
[sudokuBoard[45],sudokuBoard[46],sudokuBoard[47],
sudokuBoard[48],sudokuBoard[49],sudokuBoard[50],
sudokuBoard[51],sudokuBoard[52],sudokuBoard[53]],
[sudokuBoard[54],sudokuBoard[55],sudokuBoard[56],
sudokuBoard[57],sudokuBoard[58],sudokuBoard[59],
sudokuBoard[60],sudokuBoard[61],sudokuBoard[62]],
[sudokuBoard[63],sudokuBoard[64],sudokuBoard[65],
sudokuBoard[66],sudokuBoard[67],sudokuBoard[68],
sudokuBoard[69],sudokuBoard[70],sudokuBoard[71]],
[sudokuBoard[72],sudokuBoard[73],sudokuBoard[74],
sudokuBoard[75],sudokuBoard[76],sudokuBoard[77],
sudokuBoard[78],sudokuBoard[79],sudokuBoard[80]]]

cols = [[sudokuBoard[0],sudokuBoard[9],sudokuBoard[18],
sudokuBoard[27],sudokuBoard[36],sudokuBoard[45],
sudokuBoard[54],sudokuBoard[63],sudokuBoard[72]],
[sudokuBoard[1],sudokuBoard[10],sudokuBoard[19],
sudokuBoard[28],sudokuBoard[37],sudokuBoard[46],
sudokuBoard[55],sudokuBoard[64],sudokuBoard[73]],
[sudokuBoard[2],sudokuBoard[11],sudokuBoard[20],
sudokuBoard[29],sudokuBoard[38],sudokuBoard[47],
sudokuBoard[56],sudokuBoard[65],sudokuBoard[74]],
[sudokuBoard[3],sudokuBoard[12],sudokuBoard[21],
sudokuBoard[30],sudokuBoard[39],sudokuBoard[48],
sudokuBoard[57],sudokuBoard[66],sudokuBoard[75]],
[sudokuBoard[4],sudokuBoard[13],sudokuBoard[22],
sudokuBoard[31],sudokuBoard[40],sudokuBoard[49],
sudokuBoard[58],sudokuBoard[67],sudokuBoard[76]],
[sudokuBoard[5],sudokuBoard[14],sudokuBoard[23],
sudokuBoard[32],sudokuBoard[41],sudokuBoard[50],
sudokuBoard[59],sudokuBoard[68],sudokuBoard[77]],
[sudokuBoard[6],sudokuBoard[15],sudokuBoard[24],
sudokuBoard[33],sudokuBoard[42],sudokuBoard[51],
sudokuBoard[60],sudokuBoard[69],sudokuBoard[78]],
[sudokuBoard[7],sudokuBoard[16],sudokuBoard[25],
sudokuBoard[34],sudokuBoard[43],sudokuBoard[52],
sudokuBoard[61],sudokuBoard[70],sudokuBoard[79]],
[sudokuBoard[8],sudokuBoard[17],sudokuBoard[26],
sudokuBoard[35],sudokuBoard[44],sudokuBoard[53],
sudokuBoard[62],sudokuBoard[71],sudokuBoard[80]]]


#go through each element, and if it has a value,
#manipulate the possible values in the rows, columns,
#and blocks for the relevant item
puts "INITIAL BOARD SCAN"
for i in 0..80
	if sudokuBoard[i].hasValue?
		n = sudokuBoard[i]
		for k in 0...9
			if blocks[k].include?(n)
				currentPlace = blocks[k]
			end
		end
		for j in 0...9
			currentPlace[j].subtractValue n.value
		end

		for k in 0...9
			if rows[k].include?(n)
				currentPlace = rows[k]
			end
		end
		for j in 0...9
			currentPlace[j].subtractValue n.value
		end

		for k in 0...9
			if cols[k].include?(n)
				currentPlace = cols[k]
			end
		end

		for j in 0...9
			currentPlace[j].subtractValue n.value
		end
	end
end

puts "INITIAL BOARD EVALUATED!"


##BEGIN SOLVING!!!

puts "LOOPING THROUGH AND SOLVING PUZZLE..."
iterations = 0
while numberWritten < 81 && iterations < 100
	iterations = iterations + 1
	for i in 0..80
		if sudokuBoard[i].possibleValues.length==1
			sudokuBoard[i].writeValue(sudokuBoard[i].possibleValues[0])
			numberWritten = numberWritten+1
			n=sudokuBoard[i]
			for k in 0...9
				if blocks[k].include?(n)
					currentPlace = blocks[k]
				end
			end

			for j in 0...9
				currentPlace[j].subtractValue n.value
			end

			for k in 0...9
				if rows[k].include?(n)
					currentPlace = rows[k];
				end
			end
			for j in 0...9
				currentPlace[j].subtractValue n.value
			end

			for k in 0...9
				if cols[k].include?(n)
					currentPlace = cols[k];
				end
			end
			for j in 0...9
				currentPlace[j].subtractValue n.value
			end
		end
	end
end
puts "...FINISHED SOLVING!"

#Output finished puzzle
puts "Iterations: #{iterations}"
puts "numberWritten: #{numberWritten}"

	puts "SOLVED PUZZLE:\n\n"
	strang = ""
	for i in 0...9
		for j in 0...9
			strang = strang + sudokuBoard[(i*9)+j].value.to_s
			if (j+1) % 3 == 0 && j != 8
				strang = strang + "|"
			end
		end
		puts "#{strang}"
		if (i+1) % 3 == 0 && i != 8
			puts "-----------"
		end
		strang = ""
	end
if numberWritten != 81
	puts "SOMETHING WENT WRONG. It appears an infinite loop occured..."
end
#Test for correctness
pass = true
placeValues = []
#Test Blocks
for i in 0...9
	for j in 0...9
		placeValues.push(blocks[i][j].value)
	end
	for k in 1..9
		if placeValues.count(k) != 1
			pass = false
		end 
	end
	placeValues.clear
end
#Test Rows
for i in 0...9
	for j in 0...9
		placeValues.push(rows[i][j].value)
	end
	for k in 1..9
		if placeValues.count(k) != 1
			pass = false
		end 
	end
	placeValues.clear
end
#Test Columns
for i in 0...9
	for j in 0...9
		placeValues.push(cols[i][j].value)
	end
	for k in 1..9
		if placeValues.count(k) != 1
			pass = false
		end 
	end
	placeValues.clear
end
if pass
	puts "Everything look good!!! This solution is correct."
else
	puts "This solution appears to be incorrect..."
end