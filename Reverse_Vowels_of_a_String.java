/*
 * Given a string s, reverse only all the vowels in the string and return it.
 *
 * The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower
 * and upper cases, more than once.
 *
 *
 *
 * Example 1:
 *
 * Input: s = "hello"
 * Output: "holle"
 * Example 2:
 *
 * Input: s = "leetcode"
 * Output: "leotcede"
 *
 *
 * Constraints:
 *
 * 1 <= s.length <= 3 * 105
 * s consist of printable ASCII characters.
 */

/*
 * Solution 1:
 * 2 pointer
 */

/*use two pointers, one point start, one point end
once find vowels at start and end, swap them*/

public class Solution {
    public String reverseVowels(String s) {
        if (s == null || s.length() == 0)
            return s;
        String vowel = "aeiouAEIOU";
        int start = 0;
        int end = s.length() - 1;
        char[] c = s.toCharArray();
        while (start < end) {
            // +"" to transfer char to String
            while (start < end && !vowel.contains(c[start] + ""))
                start++;
            while (start < end && !vowel.contains(c[end] + ""))
                end--;
            char temp = c[start];
            c[start++] = c[end];
            c[end--] = temp;
        }
        // use new String(c) to convert char[] to String
        // String.valueOf(c)
        return new String(c);
    }
}
