/*
You are given NN numbers. Store them in an array and find the second largest number.

Here are some useful videos related to arrays in JavaScript:



Also, W3 Schools has a nice, well summarized tutorial related to arrays in Javascript.

Input Format

The first line contains NN, the size of array AA.
The second line contains NN space separated elements of array AA.

Output Format

Output the value of the second largest number in array AA.

Sample Input

5
2 3 6 6 5
Sample Output

5
*/

function largeNumber(a,b)
{
    if(a>b) return -1;
    if(a<b) return 1;
    return 0;
}

function processData(myArray) {
    myArray.sort(largeNumber);
    var c = 1;
    for(var i = 1; i < myArray.length; i++)
        {
            if(myArray[i] != myArray[i-1])
                {
                    myArray[c] = myArray[i];
                    c++;
                }
        }
    console.log(myArray[1]);
}


// tail starts here
process.stdin.resume();
process.stdin.setEncoding("ascii");
_input = "";
process.stdin.on("data", function (input) {
    _input += input;
});

process.stdin.on("end", function () {
   processData(_input.split('\n')[1].split(' ').map(Number));
});
