/*
An integer has sequential digits if and only if each digit in the number is one more than the previous digit.

Return a sorted list of all the integers in the range [low, high] inclusive that have sequential digits.



Example 1:

Input: low = 100, high = 300
Output: [123,234]
Example 2:

Input: low = 1000, high = 13000
Output: [1234,2345,3456,4567,5678,6789,12345]


Constraints:

10 <= low <= high <= 10^9
*/

/*
Solution 2:
generate all possible sequential numbers, to see if they are in range or not

Time Complexity: O(9 * 9)
Space Complexity: O(1)
*/
class Solution {
    public List<Integer> sequentialDigits(int low, int high) {
        List<Integer> list = new ArrayList<>();
        for(int i = 1; i <= 9; i++) {
            int num = i;
            while (num <= high && num % 10 != 0) {
                if (num >= low) {
                    list.add(num);
                }
                num = num * 10 + (num % 10) + 1;
            }
        }
        Collections.sort(list);
        return list;
    }
}