#create Block element. Block contains the block number, its elements, a
#reset button, and number of possible focus number locations
class BlockElement
	def initialize(num, rows, columns)
		@blockNumber = num
		@blockRows = rows
		@blockColumns = columns
	end
	attr_reader :blockNumber, :blockRows, :blockColumns
end

numberWritten=0

puts "\n\n\nHELLO, AND WELCOME TO THE AUTOMATED SUDOKU SOLVER!\n\n\n"

#open well formated text file (sudoku) and 
#read its content 
puts "Please enter a well formated sudoku file: "
fileString = gets.chomp
puts "GETTING SUDOKU FILE"
puzzle = File.open(fileString, "r") { |file| file.read }
puts "Initial Puzzle:\n#{puzzle}"

#create 81 elements to be the 9x9 sudoku board
puts "CREATING SUDOKU BOARD"
sudokuBoard = Array.new(81)
for i in 0...81
	sudokuBoard[i] = String.new
end

#read initial board into elements
puts "INITIALIZING SUDOKU BOARD"
a=0;
puzzle.each_char {|c|
	unless c == '|' || c == '-' || c == "\n"
		unless c=='.'
			sudokuBoard[a] = c
			numberWritten = numberWritten+1
		else
			sudokuBoard[a] = 0.to_s 
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

blocksE = [BlockElement.new(0, [0,1,2], [0,1,2]),
BlockElement.new(1, [0,1,2], [3,4,5]),
BlockElement.new(2, [0,1,2], [6,7,8]),
BlockElement.new(3, [3,4,5], [0,1,2]),
BlockElement.new(4, [3,4,5], [3,4,5]),
BlockElement.new(5, [3,4,5], [6,7,8]),
BlockElement.new(6, [6,7,8], [0,1,2]),
BlockElement.new(7, [6,7,8], [3,4,5]),
BlockElement.new(8, [6,7,8], [6,7,8])]

##BEGIN SOLVING!!!

puts "LOOPING THROUGH AND SOLVING PUZZLE..."

iterations = 0
while numberWritten < 81 && iterations < 100
	iterations = iterations + 1

	for focusNumber in 1..9
		for focusBlock in 0...9
#			puts "FN: #{focusNumber} FB: #{focusBlock}"
			unless blocks[focusBlock].include?(focusNumber.to_s)
				possibleSpots = []
				for i in 0...9
					if blocks[focusBlock][i] == 0.to_s
						possibleSpots.push(i)
					end
				end
				#rows
				for i in 0..2
					for x in 0...9
						if rows[blocksE[focusBlock].blockRows[i]][x] == focusNumber.to_s
							possibleSpots.delete(i*3)
							possibleSpots.delete(i*3+1)
							possibleSpots.delete(i*3+2)
						end
					end
				end
				#columns
				for i in 0..2
					for x in 0...9
						if cols[blocksE[focusBlock].blockColumns[i]][x] == focusNumber.to_s	
							possibleSpots.delete(i)
							possibleSpots.delete(i+3)
							possibleSpots.delete(i+6)
						end
					end
				end

				if possibleSpots.length == 1
#					puts "*** WRITING A VALUE #{focusNumber} to Block #{focusBlock}[#{possibleSpots[0]}]"
					blocks[focusBlock][possibleSpots[0]].replace focusNumber.to_s
#					puts "new: #{blocks[focusBlock][possibleSpots[0]]}"

					numberWritten = numberWritten+1
				end
			end		
		end	
	end
end
puts "...FINISHED SOLVING!"
puts "iterations: #{iterations}"
puts "numberWritten: #{numberWritten}"

#Output finished puzzle


	puts "SOLVED PUZZLE:\n\n"
	strang = ""
	for i in 0...9
		for j in 0...9
#			puts "sudokuBoard[#{(i*9)+j}]: #{sudokuBoard[(i*9)+j]}"
			strang = strang + sudokuBoard[(i*9)+j].to_s
#			puts "Strang: #{strang}"
			if (j+1) % 3 == 0 && j != 8
				strang = strang + "|"
			end
		end
#		puts "OFFICIAL:"
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
		placeValues.push(blocks[i][j])
	end
	for k in 1..9
		if placeValues.count(k.to_s) != 1
			pass = false
		end 
	end
	placeValues.clear
end
#Test Rows
for i in 0...9
	for j in 0...9
		placeValues.push(rows[i][j])
	end
	for k in 1..9
		if placeValues.count(k.to_s) != 1
			pass = false
		end 
	end
	placeValues.clear
end
#Test Columns
for i in 0...9
	for j in 0...9
		placeValues.push(cols[i][j])
	end
	for k in 1..9
		if placeValues.count(k.to_s) != 1
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