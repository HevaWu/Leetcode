/*
Explanation

If/else statements are conditional statements that are used to perform different actions based upon different conditions.

If/else statements

The if statement executes a block of code if the specified condition is true:

Syntax

 if (condition) {
        //block of code
} 
The else statement executes a block of code if all of the conditions are false:

Syntax

 if (condition) {
        //block of code if condition is true
} else {
        //block of code if none of the condition(s) is true.
}
The else if statement executes a block of code if its condition is true, and the previous conditions are false:

Syntax

 if (condition) {
        //block of code if condition is true
} else if (condition_2) {
        //block of code if condition is false and condition_2 is true.
} else if (condition_3) {
        //block of code if condition is false and condition_2 is false and condition_3 is true.
} else {
        //block of code if none of the condition(s) is true.
}
Example

if (time < 12) {
    console.log("Good morning");
} else if (time < 14) {
    console.log("Good Afternoon");
} else {
    console.log("Good evening");
} 
Task

You are given a variable marks. Your task is to print: 

- AA if marks is greater than 9090. 
- AB if marks is greater than 8080 and less than or equal to 9090. 
- BB if marks is greater than 7070 and less than or equal to 8080. 
- BC if marks is greater than 6060 and less than or equal to 7070. 
- CC if marks is greater than 5050 and less than or equal to 6060. 
- CD if marks is greater than 4040 and less than or equal to 5050. 
- DD if marks is greater than 3030 and less than or equal to 4040. 
- FF if marks is less than or equal to 3030.

Note

Do not declare the variable marks. It is declared inside our code checker.
Use console.log for printing statements to the console.
*/

//Do not declare variable marks.
//Write your code below this line.
if(marks>90)
    console.log("AA");
else if(marks>80)
    console.log("AB");
else if(marks>70)
    console.log("BB");
else if(marks>60)
    console.log("BC");
else if(marks>50)
    console.log("CC");
else if(marks>40)
    console.log("CD");
else if(marks>30)
    console.log("DD");
else
    console.log("FF");

