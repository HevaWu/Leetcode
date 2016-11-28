/*
Here is a sample line of code that can be executed in Javascript:

console.log("Hello World!");
You can also store a string in a variable and print it:

var my_string = "Hello World!";
console.log(my_string);
Try it out! Write a function that prints Hello World in the console below.
*/

function processData(input) {
    //Enter your code here
    //console.log("Hello World!");
    var my_string = "Hello World!";
    console.log(my_string);
} 

process.stdin.resume();
process.stdin.setEncoding("ascii");
_input = "";
process.stdin.on("data", function (input) {
    _input += input;
});

process.stdin.on("end", function () {
   processData(_input);
});
