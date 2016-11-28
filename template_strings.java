/*
var type = 'grizzly';  //let type =...

while(true){
	var type = 'polar';  //let type = ...
	console.log(type)
	break;
}

console.log(type); // polar  polar, if change to let, the result will be polar,grizzly
*/

/*
const PI = Math.PI;
const moment = require('moment');  //no need to manipulate the variable part
*/


// class Bear{
// 	constructor(){
// 		this.type = 'bear';
// 	}
// 	says(say){
// 		console.log(this.type + 'says' + say)
// 	}
// }

// int bear = new Bear();
// bear.says('growl');  //bear says growl

// function Bear(){

// }

// Bear()

// class Grizzly extends Bear{
// 	constructor(){
// 		super();//call the objects extending
// 		this.type = 'grizzly';
// 	}
// }

// int bear = new Grizzly();
// bear.says('growl'); //bear says growl

// let bears = ['polar','koala'].filter((bear) => bear != 'koala');
// let bears = ['polar','koala'].filter((bear) => {
// 	return bear != 'koala';
// });
// console.log(bears);  //['polar']

// class Bear{
// 	constructor(){
// 		this.type = 'bear';
// 	}
// 	says(say){
// 		setTimeout(()=>{
// 		console.log(this.type + 'says' + say);
// 	}.bind(this),1000)
// 	}
// }
// var bear = new Bear();
// bear.says(); //bear says undefined

// var bears = [
// 	'grizzly',
// 	'polar',
// ].join('\n')         // grizzly
// console.log(bears)   // polar

// let bears = '
// 	grizzly
// 	polar
// '
// console.log(bears)

// let bears = 'grizzly';
// let says = 'growl';
// console.log('The ${bear} says ${says');  //The grizzly says growl

// let bear = 'grizzly';
// let says = 'growl';
// let zoo = {bear, says}
// console.log(zoo); //Object {bear:"grizzly", says:"growl"}

// let grizzly = {type:'grizzly', many:2};
// let{type, many} = grizzly;
// console.log(many,type); //2"gizzly"

// function bear(type){
// 	type = type || 'grizzly';
// 	console.log(type);  //girzzly
// }
// bear()

// function bear(type = 'grizzly'){
// 	console.log(type);  //girzzly
// }
// bear()

// function bear(...type){
// 	console.log(type);  
// }
// bear('polar','grizzly'); //{"polar","grizzly"}

/*
JavaScript ES6 Template Strings

Here's a useful video related to the major features in ES6 including template strings:


Template strings introduce a way to define strings with domain-specific languages (DSLs). It provides improved string interpolation, embedded expressions, multiline strings, formatting, and tagging for safe HTML.

Template Strings

Template strings are string literals allowing embedded expressions. 
We can use multi-line strings and string interpolation features with them.

Multiline Strings

Any new line characters inserted in the source are part of the template string. 
SAMPLE CODE

console.log(`The HackerRank team is on a mission to flatten the world by restructuring 
the DNA of every company on the planet. We rank programmers based on 
their coding skills, helping companies source great programmers and reduce 
the time to hire.`);
OUTPUT

The HackerRank team is on a mission to flatten the world by restructuring 
the DNA of every company on the planet. We rank programmers based on 
their coding skills, helping companies source great programmers and reduce 
the time to hire.
String Interpolation

We can embed expressions within template strings by making use of its syntactic sugar. 
SAMPLE CODE

var contestant = "DOSHI";
var score = "20";

console.log(`Congratulations ${contestant}!, Your score is ${score}.`);
OUTPUT

Congratulations DOSHI!, Your score is 20.
Task

Your task is to create a template string and assign it to the variable my_template_string.

The template string should contain the following data only:

My name is ${my_name}.
My id is ${my_id}.
My address is ${my_address}.
Note

Do not create any variable other than my_template_string.
Do not print anything on the console.
Replace the blank (_______________________) with the template string.
*/
/*
TO ANYONE STRUGGLING: 
YOU HAVE TO USE ` INSTEAD OF ' or ". 
You can find that key under the 'Esc' button, to the left of 1, above the 'tab' button on your keyboard.
*/

var my_template_string = 
`My name is ${my_name}.
My id is ${my_id}.
My address is ${my_address}.`;


