/*
JavaScript ES6 for . . . of

Here's a nice discussion about the for-of loop that is introduced in ES6 and the purpose it serves.

for . . . of

The for...of statement creates a loop iterating over iterable objects like arrays, maps, and argument objects. It invokes a custom iteration hook with statements to be executed for the value of each distinct property.

SAMPLE CODE

var employee = ['001', '002', '003', '004', '005', '006', '007'];
for(let i in employee){
    console.log(i);
}
console.log();
for(let i of employee){
    console.log(i);
}
OUTPUT

0
1
2
3
4
5
6

001
002
003
004
005
006
007
Task

We have created an array my_array whose elements are strings. Your task is to print the elements which are palindromes.

Constraints

0≤size of array≤1000≤size of array≤100 
0≤size of each string≤1000≤size of each string≤100
Hint

You can learn about how to reverse a string in place, here.

Note

Do not declare the variable my_array.
*/

//Write your code below this line.
/*
for(var i of my_array){
    if(i == i.split('').reverse().join(''))
    console.log(i);
}
*/
"use strict"
for(let i of my_array){
    if(i == i.split('').reverse().join(''))
    console.log(i);
}
 
