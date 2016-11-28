/*
The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

P   A   H   N
A P L S I I G
Y   I   R
And then read line by line: "PAHNAPLSIIGYIR"
Write the code that will take a string and make this conversion given a number of rows:

string convert(string text, int nRows);
convert("PAYPALISHIRING", 3) should return "PAHNAPLSIIGYIR".
*/

class Solution {
public:
    string convert(string s, int numRows) {
        if(numRows<=1) return s;  //if there is only one line, it is no need to change the string
        
        int sCircle = 2 * numRows - 2;  //count the number of elements in one circle
        string sRes = "";  
        for(int i = 0; i < numRows; ++i){  //let i control the rows
            for(int j = i; j < s.size(); j += sCircle){
                sRes += s[j];
                int secondS = (j-i) + sCircle-i;
                if(i!=0 && i!=numRows-1 && secondS<s.size())   //the first line and the last line has not the second elements
                    sRes += s[secondS];
            }
        }
        return sRes;
        
        /*
        The distribution of the elements is period.

P   A   H   N
A P L S I I G
Y   I   R
For example, the following has 4 periods(cycles):

P   | A   | H   | N
A P | L S | I I | G
Y   | I   | R   |
The size of every period is defined as "cycle"

cycle = (2*nRows - 2), except nRows == 1.
In this example, (2*nRows - 2) = 4.

In every period, every row has 2 elements, except the first row and the last row.

Suppose the current row is i, the index of the first element is j:

j = i + cycle*k, k = 0, 1, 2, ...
The index of the second element is secondJ:

secondJ = (j - i) + cycle - i
(j-i) is the start of current period, (j-i) + cycle is the start of next period.
        */
    }
};