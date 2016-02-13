
	
	var marked;
	var content;
	var cell;
	var restart=false;
	var squaresFilled = 0;
	var winningCombinations;
	winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]];
	//Create array. All content will be set to empty space and marked will be set to false (meaning that it has yet to be marked)
	window.onload=function(){

	marked = new Array();
	content = new Array();
	

	for (var i=0; i<=8; i++){
		marked[i] = false;
		content [i] = ' ';
		}
	}
	
	//marks the player's choice with an X - not working!!
	function markBox(cellNum) {
		cell = document.getElementById('cell' + cellNum);
		if (marked[cellNum-1] == false) {
			content[cellNum-1] = 'X';
			cell.innerHTML = 'X';
			marked[cellNum-1] = true;
			console.log(marked);
			console.log(content);
			squaresFilled++;
			determineWinner(content[cellNum-1]);
			/* if player won, should not process computer turn*/
			if (restart==false) {
				computerTurn();
			}else {
				restart = false;
			}
		}
		
	}
	
	//Will determine who the winner is
	function determineWinner(player) {
		for (var i=0; i<winningCombinations.length; i++){
			if(content[winningCombinations[i][0]]==player && content[winningCombinations[i][1]]==player && content[winningCombinations[i][2]]==player){
				if(player == 'X') {
					alert("You Won!");
					restart = true;
					location.reload(true);
					break;
				}
				else {
					alert("Sorry, the Computer Won!");
					restart = true;
					location.reload(true);
					break;
				}
			}
		}
		
		if(squaresFilled==9 && restart!=true){
			alert("Tied Game!");
			restart = true;
			location.reload(true);
		}
		
	}
	
	function computerTurn(){
		//Will receive a number from 1-9
		var num = Math.floor(9*Math.random()) + 1;
		console.log(num);
		//Trying to find an available cell
		while (marked[num-1] == true) {
			num = Math.floor(9*Math.random()) + 1;
			console.log(num);
		}
		//Once find an available cell, marking with an O
		content[num-1] = 'O';
		cell = document.getElementById("cell" + num);
		cell.innerHTML = 'O';
		marked[num-1] = true;
		console.log(marked);
		console.log(content);
		squaresFilled++;
		determineWinner(content[num-1]);
	}
	
	