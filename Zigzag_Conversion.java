/*
The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

P   A   H   N
A P L S I I G
Y   I   R
And then read line by line: "PAHNAPLSIIGYIR"

Write the code that will take a string and make this conversion given a number of rows:

string convert(string s, int numRows);


Example 1:

Input: s = "PAYPALISHIRING", numRows = 3
Output: "PAHNAPLSIIGYIR"
Example 2:

Input: s = "PAYPALISHIRING", numRows = 4
Output: "PINALSIGYAHRPI"
Explanation:
P     I    N
A   L S  I G
Y A   H R
P     I
Example 3:

Input: s = "A", numRows = 1
Output: "A"


Constraints:

1 <= s.length <= 1000
s consists of English letters (lower-case and upper-case), ',' and '.'.
1 <= numRows <= 1000
*/

/*
Solution 1:

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

Time Complexity: O(n * numRows)
Space Complexity: O(n)
*/
class Solution {
    public String convert(String s, int numRows) {
         if(numRows<=1) return s;  //if there is only one line, it is no need to change the string

        int sCircle = 2 * numRows - 2;  //count the number of elements in one circle
        StringBuilder sRes = new StringBuilder();
        for(int i = 0; i < numRows; ++i){  //let i control the rows
            for(int j = i; j < s.length(); j += sCircle){
                sRes.append(s.charAt(j));
                int secondS = (j-i) + sCircle-i;
                if(i!=0 && i!=numRows-1 && secondS<s.length())   //the first line and the last line has not the second elements
                    sRes.append(s.charAt(secondS));
            }
        }
        return sRes.toString();
    }
}
