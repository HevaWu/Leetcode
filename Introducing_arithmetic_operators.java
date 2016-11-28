/*
Explanation

Arithmetic operators perform arithmetic operations with numbers (literals or variables).

Here's a useful video introducing this topic:


Here is the list of JavaScript arithmetic operators:

+  : Addition
-  : Subtraction
*  : Multiplication
/  : Division
%  : Modulus
++ : Increment
-- : Decrement
The order of precedence of arithmetic operators from high to low follows:

++, --
*, \, %
+, -


Addition

SAMPLE CODE

var a = 1;
var b = 2;

var ans = a + b;

console.log(ans);
OUTPUT

3
Subtraction

SAMPLE CODE

var a = 1;
var b = 2;

var ans = a - b;

console.log(ans);
OUTPUT

-1
Multiplication

SAMPLE CODE

var a = 3;
var b = 2;

var ans = a * b;

console.log(ans);
OUTPUT

6
Division

SAMPLE CODE

var a = 3;
var b = 2;

var ans = a / b;

console.log(ans);
OUTPUT

1.5
Modulus

SAMPLE CODE

var a = 3;
var b = 2;

var ans = a % b;

console.log(ans);
OUTPUT

1
Increment

SAMPLE CODE

var a = 3;
a++;

var ans = a;

console.log(ans);
OUTPUT

4
Decrement

SAMPLE CODE

var a = 3;
a--;

var ans = a;

console.log(ans);
OUTPUT

2
Task

You are given two number variables a and b. Both of them have been declared and assigned.

Your task is to :

Create a variable add and assign it with the summation of a and b.
Create a variable sub and assign it with the subtraction of b from a.
Create a variable mul and assign it with the multiplication of a and b.
Create a variable div and assign it with the division of a by b.
Create a variable inc and assign it with the incremented value of a.
Create a variable dec and assign it with the decremented value of b.
Note: Do not create variables a and b. They have already been created and assigned inside our code checker.
*/

//Do not declare variables `a` and `b`.
//Write your code below this line.
var add = a + b;
var sub = a - b;
var mul = a * b;
var div = a / b;
a++;
var inc = a;
b--
var dec = b;
