/*
Given an integer rowIndex, return the rowIndexth row of the Pascal's triangle.

Notice that the row index starts from 0.


In Pascal's triangle, each number is the sum of the two numbers directly above it.

Follow up:

Could you optimize your algorithm to use only O(k) extra space?



Example 1:

Input: rowIndex = 3
Output: [1,3,3,1]
Example 2:

Input: rowIndex = 0
Output: [1]
Example 3:

Input: rowIndex = 1
Output: [1,1]


Constraints:

0 <= rowIndex <= 33

*/

/*
Solution 2:
Iterative

build tri array
Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    public List<Integer> getRow(int rowIndex) {
        if (rowIndex == 0) {
            return new ArrayList<>() {
                {
                    add(1);
                }
            };
        }
        List<List<Integer>> tri = new ArrayList<>();
        for (int i = 0; i <= rowIndex; i++) {
            tri.add(new ArrayList<>());
        }
        tri.get(0).add(1);
        for (int i = 1; i <= rowIndex; i++) {
            tri.get(i).add(1);
            for (int j = 1; j < i; j++) {
                tri.get(i).add(tri.get(i - 1).get(j - 1) + tri.get(i - 1).get(j));
            }
            tri.get(i).add(1);
        }
        return tri.get(rowIndex);
    }
}
