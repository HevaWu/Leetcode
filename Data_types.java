/*
Explanation

A data type is a classification identifying types of data such as string, boolean or numbers. It determines the possible values for that particular type.

JavaScript Data Types

Here's a useful video related to the topic:


JavaScript is a loosely typed or a dynamic language. That means you don't have to declare the type of a variable ahead of time.

The latest ECMAScript standard defines seven data types:

► Six data types that are primitive:

Number
Boolean
String
Symbol (new in ECMAScript 6)
Null
Undefined
► and an Object

To learn about the difference between primitive data types and objects, click here.



Numbers

Numbers can be written with or without decimals. They can also be written in scientific (exponential) notation.

EXAMPLE

var num1 = 42;      //Written without decimals. 
var num2 = 42.00;   //Written with decimals.
var num3 = 2e5;     //200000
var num4 = 2e-5;    //0.00002
Booleans

Boolean can only have two values: true or false.

EXAMPLE

var a = true;   
var b = false;
Strings

A string is written with quotes. It can be written using single or double quotes.

EXAMPLE

var website = "hackerrank";   // Using double quotes
var website = 'hackerrank';   // Using single quotes
Symbol

A symbol is a unique and immutable data type and may be used as an identifier for object properties. To create a new primitive symbol, you simply write Symbol() with an optional string as its description.

EXAMPLE

var sym = Symbol();
var sym1 = Symbol("foo");
Null

In JavaScript, null is "nothing". It is supposed to be something that doesn't exist.

EXAMPLE

var data = null;
Undefined

In JavaScript, a variable without a value has the value, undefined. Also, any variable can be emptied by setting the value to undefined.

EXAMPLE

var data;       //It has type undefined
var data1 = undefined;
Object

An object is a collection of properties. The properties are identified by using key values. Property keys are used to access the properties and their values.

Object properties are written as key:value pairs separated by commas.

EXAMPLE

var car = {color:"black", model:"X", mileage:30};
Task

Your task is to:

Create a variable my_num and assign it any number.
Create a variable my_bool and assign it any boolean.
Create a variable my_str and assign it any string.
*/

//Write your code below this line.
var my_num = 2;
var my_bool = true;
var my_str = "Hello";