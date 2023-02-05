/*
Given a string s and a non-empty string p, find all the start indices of p's anagrams(回文) in s.

Strings consists of lowercase English letters only and the length of both strings s and p will not be larger than 20,100.

The order of output does not matter.

Example 1:

Input:
s: "cbaebabacd" p: "abc"

Output:
[0, 6]

Explanation:
The substring with start index = 0 is "cba", which is an anagram of "abc".
The substring with start index = 6 is "bac", which is an anagram of "abc".
Example 2:

Input:
s: "abab" p: "ab"

Output:
[0, 1, 2]

Explanation:
The substring with start index = 0 is "ab", which is an anagram of "ab".
The substring with start index = 1 is "ba", which is an anagram of "ab".
The substring with start index = 2 is "ab", which is an anagram of "ab".
*/

/*
Solution 2:
build int array of 2 string
and compare base(p array) and cur(s array checking part)

Time Complexity: O(n_s + n_p)
Space Complexity: O(n_s + n_p)
*/
class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> ana = new ArrayList<>();

        int[] freqP = new int[26];
        int np = p.length();
        for(int i = 0; i < np; i++) {
            freqP[p.charAt(i)-'a'] += 1;
        }

        int[] freqS = new int[26];
        int ns = s.length();
        for(int i = 0; i < ns; i++) {
            freqS[s.charAt(i)-'a'] += 1;
            int start = i-np;
            if (start >= 0) {
                freqS[s.charAt(start)-'a'] -= 1;
            }

            if (Arrays.equals(freqS, freqP)) {
                ana.add(start+1);
            }
        }
        return ana;
    }
}
