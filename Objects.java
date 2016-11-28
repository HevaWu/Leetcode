/*
JavaScript Objects

Objects are variables too, but objects can contain many values. This code assigns many values (Fiat, 500, white) to a variable named car:

var car = {type:"Fiat", model:500, color:"white"};
The values are written as name:value pairs. The name and value are separated by a colon. The name:values pairs (in JavaScript objects) are called properties.

Here's a useful video discussing JavaScript Objects in general:


Accessing Object Properties

You can access object properties in two ways:

objectName.propertyName
or

objectName["propertyName"]
Task

You are given a single line consisting of property type values of a car in the following order:

TypeName ModelName ColorName
Assign these values to an object car that has the properties type, model and color appropriately and print the object.

Sample Input

Fiat 500 White
Sample Output

{ type: 'Fiat', model: '500', color: 'White' }
*/

function printObjectProperty(myObject) {
this.type = myObject.type;
    this.model = myObject.model;
    this.color = myObject.color;
    console.log("{ type: '" + type + "', model: '" + model + "', color: '" + color + "' }");
} 

// tail starts here
process.stdin.resume();
process.stdin.setEncoding("ascii");
_input = "";
process.stdin.on("data", function (input) {
    _input += input;
});

process.stdin.on("end", function () {
    var obj = _input.split(' ');
    var myObject = new Object;
    myObject.type = obj[0];
    myObject.model = obj[1];
    myObject.color = obj[2];

    printObjectProperty(myObject);
});
