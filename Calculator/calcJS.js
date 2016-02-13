var mem;
var currentExpression = new Array(0);
var expressions = new Array(0);

function update(a) {
  if(a != null){  
    var b = currentExpression.pop();
    if(isNaN(b)) {
      if(b != null){currentExpression.push(b);}
     currentExpression.push(a);
    } else {
      currentExpression.push((b*10)+a);
    }
  }
  document.getElementById("output").value=currentExpression;
}

function operate(a) {
  if(currentExpression.length >0 && !isNaN(currentExpression[currentExpression.length-1])) {
    currentExpression.push(a);
  } else {alert("Please enter operand");}
  update(null);
}

function eval() {
  expressions.push(currentExpression.slice(0));
  var b=0;
  /*DIVISION*/
  while(b>=0){
  b = currentExpression.indexOf("/");
  if(b>0){
    currentExpression[b] = evaluateExpression(currentExpression[b-1],"/",currentExpression[b+1]);
    fixExpression(b);
  }
  }
  b=0;

  /*MULTIPLICATION*/
  while(b>=0){
  b = currentExpression.indexOf("*");
  if(b>0){
    currentExpression[b] = evaluateExpression(currentExpression[b-1],"*",currentExpression[b+1]);
    fixExpression(b);
  }
  }
  b=0;

  /*SUBTRACTION*/
  while(b>=0){
  b = currentExpression.indexOf("-");
  if(b>0){
    currentExpression[b] = evaluateExpression(currentExpression[b-1],"-",currentExpression[b+1]);
    fixExpression(b);
  }
  }
  b=0;

  /*ADDITION*/
  while(b>=0){
  b = currentExpression.indexOf("+");
  if(b>0){
    currentExpression[b] = evaluateExpression(currentExpression[b-1],"+",currentExpression[b+1]);
    fixExpression(b);
  }
  }
  b=0;
  expressions.push(currentExpression[0]);
  document.getElementById("div").innerHTML += expressions[expressions.length-2] + "=" + expressions[expressions.length-1] + "<br>";
  
  update(null);
  clr(0);
}

function evaluateExpression(a,b,c) {
  if(b=="/") {return a/c;}
  if(b=="*") {return a*c;}
  if(b=="-") {return a-c;}
  if(b=="+") {return a+c;}
}

function fixExpression(a) {
  currentExpression[a-1] = currentExpression[a];
  for(var i = a+2; i<currentExpression.length; i++) {
    currentExpression[i-2] = currentExpression[i];
  }
  currentExpression.length=currentExpression.length-2;
//alert("New currentExpression(withoutFix) is: " + currentExpression);
}

function clr(a) {
    currentExpression.length=0;
    if(a) {
      expressions.length=0;
      document.getElementById("div").innerHTML = "";
    }
//    update(null);

}

function memChange(a){
  if(a=='+' && expressions.length>0) {
    mem = expressions[expressions.length-1];
    document.getElementById("div").style.backgroundColor = 'red';
  } else {
    mem = null;
    document.getElementById("div").style.backgroundColor = 'transparent';
  }
}

function memUse(a){
  if(mem != null) {
  eval();
  update(expressions[expressions.length-1]);
  operate(a);
  update(mem);
  eval();
  } else {
    alert("No number in memory");
  }
}