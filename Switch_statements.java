/*
Explanation

The switch statement evaluates an expression, matches the expression's value to a case clause, and executes the statements associated with that particular case.

Switch Statements

Here's a useful video on the topic:


A switch statement first evaluates its expression.
Then, it looks for the first case clause whose expression matches the same value as the result of the input expression (using strict comparison, ===).
Finally, it transfers control to that clause.

Syntax

switch (expression) {
  case value1:
    //Statements executed when the result of expression matches value1
    [break;]
  case value2:
    //Statements executed when the result of expression matches value2
    [break;]
  ...
  case valueN:
    //Statements executed when the result of expression matches valueN
    [break;]
  default:
    //Statements executed when none of the values match the value of the expression
    [break;]
}
With each case label, there is an optional break statement to ensure that the program breaks out of the switch once the matching statement is performed and continues execution at the statement following the switch.

If the break is omitted, the program continues execution at the next statement within the switch statement.

Example

switch (day) {  //day is an integer varying from 0 to 6.
    case 6:
        text = "Today is Saturday";
        break;
    case 0:
        text = "Today is Sunday";
        break;
    default:
        text = "Looking forward to the Weekend";
} 
Task

You are given a variable num. Your task is to print: 

- ONE, if num is equal to 11. 
- TWO, if num is equal to 22. 
- THREE, if num is equal to 33.
- FOUR, if num is equal to 44.
- FIVE, if num is equal to 55.
- SIX, if num is equal to 66.
- SEVEN, if num is equal to 77.
- EIGHT, if num is equal to 88.
- NINE, if num is equal to 99.
- PLEASE TRY AGAIN, if num is none of the above.

Note

Do not declare the variable num. It is declared inside our code checker.
Use console.log for printing statements to the console.
*/

//Do not declare variable num.
//Write your code below this line.
switch(num){
    case 1:
        console.log("ONE");
        break;
    case 2:
        console.log("TWO");
        break;
    case 3:
        console.log("THREE");
        break;
    case 4:
        console.log("FOUR");
        break;
    case 5:
        console.log("FIVE");
        break;
    case 6:
        console.log("SIX");
        break;
    case 7:
        console.log("SEVEN");
        break;
    case 8:
        console.log("EIGHT");
        break;
    case 9:
        console.log("NINE");
        break;
    default:
        console.log("PLEASE TRY AGAIN");
}
