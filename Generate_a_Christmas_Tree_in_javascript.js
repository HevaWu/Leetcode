/*
Write a JavaScript program to generate the Christmas Tree pattern below. The tree should be composed of zeroes (0), and it must be topped with an asterisk (*).

        *
        0
       000
      00000
     0000000
    000000000
   00000000000
  0000000000000
 000000000000000
00000000000000000
Note: The leftmost 00 should be aligned with the left edge and there should not be any blank spaces preceding it on the last line.

Input Format

No input is required to complete this challenge.
*/

function processData(input) {
    //Enter your code here
    for(var i = 0; i < 10; i++){
        var s = '';
        var n0,n1;
        if(i == 0) n0 = 8;
        else n0 = 9-i;
        for(var j = 0; j < n0; j++)
            s += ' ';
        if(i == 0) s += '*';
        else{
            n1 = 2*i-1;
            for(var j = 0; j < n1; j++)
                s += '0';
        }
        console.log(s);
    }
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
