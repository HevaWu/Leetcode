/*
A string S of lowercase English letters is given. We want to partition this string into as many parts as possible so that each letter appears in at most one part, and return a list of integers representing the size of these parts.



Example 1:

Input: S = "ababcbacadefegdehijhklij"
Output: [9,7,8]
Explanation:
The partition is "ababcbaca", "defegde", "hijhklij".
This is a partition so that each letter appears in at most one part.
A partition like "ababcbacadefegde", "hijhklij" is incorrect, because it splits S into less parts.


Note:

S will have length in range [1, 500].
S will consist of lowercase English letters ('a' to 'z') only.
*/

/*
Solution 2:
greedy

- use last to store lastIndex of character c
- Iterate s, updated end, if end == i, we found one partition, append it into result

Time Complexity: O(n)
Space Complexity: O(1) - 26 characters
*/
class Solution {
    public List<Integer> partitionLabels(String s) {
        int[] last = new int[26];
        for(int i = 0; i < s.length(); i++) {
            last[s.charAt(i) - 'a'] = i;
        }

        int start = 0;
        int end = 0;
        List<Integer> partition = new ArrayList<>();
        for(int i = 0; i < s.length(); i++) {
            end = Math.max(end, last[s.charAt(i) - 'a']);
            if (end == i) {
                partition.add(end - start + 1);
                start = end + 1;
            }
        }
        return partition;
    }
}