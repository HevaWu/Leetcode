/*
Write a JavaScript program to generate the pattern below, composed of the following characters: ╱ and ╲.

╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
╱╲╱╲╱╲╱╲╱╲╱╲╱╲
Input Format

No input is required to complete this challenge.
*/

function processData(input) {
    //Enter your code here
    for(var i = 0; i < 14; i++){
        var s = '';
        for(var j = 0; j < 14; j++){
            if(j%2 == 0) s += String.fromCharCode(9585);  //'/'
            else if(j%2 == 1) s += String.fromCharCode(9586);//'\'
        }
        console.log(s);
    }
} 
/*
Copying and pasting the slashes from the question and using ""╲".charCodeAt();" gave me 9585 and 9586 so I used:
const backSlash = String.fromCharCode(9585); const forwardSlash = String.fromCharCode(9586);
*/

process.stdin.resume();
process.stdin.setEncoding("ascii");
_input = "";
process.stdin.on("data", function (input) {
    _input += input;
});

process.stdin.on("end", function () {
   processData(_input);
});
