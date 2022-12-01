/*
You are given a string s of even length. Split this string into two halves of equal lengths, and let a be the first half and b be the second half.

Two strings are alike if they have the same number of vowels ('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'). Notice that s contains uppercase and lowercase letters.

Return true if a and b are alike. Otherwise, return false.



Example 1:

Input: s = "book"
Output: true
Explanation: a = "bo" and b = "ok". a has 1 vowel and b has 1 vowel. Therefore, they are alike.
Example 2:

Input: s = "textbook"
Output: false
Explanation: a = "text" and b = "book". a has 1 vowel whereas b has 2. Therefore, they are not alike.
Notice that the vowel o is counted twice.
Example 3:

Input: s = "MerryChristmas"
Output: false
Example 4:

Input: s = "AbCdEfGh"
Output: true


Constraints:

2 <= s.length <= 1000
s.length is even.
s consists of uppercase and lowercase letters.

*/

/*
Solution 1:
2 pointer iterative string from head and last

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    public boolean halvesAreAlike(String s) {
        int left = 0;
        int right = s.length()-1;

        int first = 0;
        int second = 0;

        Set<Character> vowelSet = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'));

        while (left < right) {
            if (vowelSet.contains(s.charAt(left))) {
                first += 1;
            }
            if (vowelSet.contains(s.charAt(right))) {
                second += 1;
            }
            left += 1;
            right -= 1;
        }

        return first == second;
    }
}
