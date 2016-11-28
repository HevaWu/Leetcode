/*
You are given a matrix with mm rows and nn columns of cells, each of which contains either 11 or 00. Two cells are said to be connected if they are adjacent to each other horizontally, vertically, or diagonally. The connected and filled (i.e. cells that contain a 11) cells form a region. There may be several regions in the matrix. Find the number of cells in the largest region in the matrix.

Input Format
There will be three parts of t input:
The first line will contain mm, the number of rows in the matrix.
The second line will contain nn, the number of columns in the matrix.
This will be followed by the matrix grid: the list of numbers that make up the matrix.

Output Format
Print the length of the largest region in the given matrix.

Constraints
0<m<100<m<10
0<n<100<n<10

Sample Input:

4
4
1 1 0 0
0 1 1 0
0 0 1 0
1 0 0 0
Sample Output:

5
Task: 
Write the complete program to find the number of cells in the largest region.

Explanation

X X 0 0
0 X X 0
0 0 X 0
1 0 0 0  
The X characters indicate the largest connected component, as per the given definition. There are five cells in this component.
*/


function processData(input) {
    //Enter your code here
    var inputData = input.split('\n');
    var nrows = inputData[0];
    var ncols = inputData[1];
    var arr = new Array();
    var n = 2;
    while(nrows-arr.length > 0){
        arr.push(inputData[n].split(' '));
        n++;
    }

    var counts = new Array();
    for(var i = 0; i < nrows; i++){
        for(var j = 0; j < ncols; j++)
            counts.push(region(i, j, nrows, ncols, arr));
    }
    
    var maxcounts = counts[0];
    for(i = 0; i < counts.length; i++){
        if(counts[i]>maxcounts) maxcounts = counts[i];
    }
    //console.log(counts);
    console.log(maxcounts);
} 

function region(irow, icol, nrows, ncols, arr)
{
    if(irow >= nrows) irow = nrows-1;
    if(icol >= ncols) icol = ncols-1;
    if(irow < 0) irow = 0;
    if(icol < 0) icol = 0;
    var count = 0;
    var arrele = arr[irow][icol];
    if(arrele == 8) return 0; //we have already count this region
    if(arrele == 0) return 0; //it is not region
    if(arrele == 1){//choose the next region
        count++;
        arr[irow][icol] = 8;
        count += region(irow+1, icol, nrows, ncols, arr);
        count += region(irow-1, icol, nrows, ncols, arr);
        count += region(irow, icol+1, nrows, ncols, arr);
        count += region(irow, icol-1, nrows, ncols, arr);
        count += region(irow+1, icol+1, nrows, ncols, arr);
        count += region(irow+1, icol-1, nrows, ncols, arr);
        count += region(irow-1, icol+1, nrows, ncols, arr);
        count += region(irow-1, icol-1, nrows, ncols, arr);
    }
    return count;
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
    

