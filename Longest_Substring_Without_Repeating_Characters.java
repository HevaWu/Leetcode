// Given a string, find the length of the longest substring without repeating characters.

// Example 1:

// Input: "abcabcbb"
// Output: 3
// Explanation: The answer is "abc", with the length of 3.
// Example 2:

// Input: "bbbbb"
// Output: 1
// Explanation: The answer is "b", with the length of 1.
// Example 3:

// Input: "pwwkew"
// Output: 3
// Explanation: The answer is "wke", with the length of 3.
//              Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

// Solution 1: Brute Force
// Check all no duplicate substrings one by one, then compare them
// Algorithm
// Suppose we have a function boolean allUnique(String substring) which will return true if the characters in the substring are all unique, otherwise false. We can iterate through all the possible substrings of the given string s and call the function allUnique. If it turns out to be true, then we update our answer of the maximum length of substring without duplicate characters.
// Now let's fill the missing parts:
// To enumerate all substrings of a given string, we enumerate the start and end indices of them. Suppose the start and end indices are ii and jj, respectively. Then we have 0 \leq i \lt j \leq n0≤i<j≤n (here end index jj is exclusive by convention). Thus, using two nested loops with ii from 0 to n - 1n−1 and jj from i+1i+1 to nn, we can enumerate all the substrings of s.
// To check if one string has duplicate characters, we can use a set. We iterate through all the characters in the string and put them into the set one by one. Before putting one character, we check if the set already contains it. If so, we return false. After the loop, we return true.
//
// TimeComplexity: O(n^3)
// SpaceComplexity: O(min(m,n)) = O(k) <- k is the size of the set, n is the string.length, m is the size of the charset/alphabet
public class Solution {
    public int lengthOfLongestSubstring(String s) {
        if(s.length() == 0) return 0;
        if(s.length() == 1) return 1;

        int n = s.length();
        int res = 0;
        for(int i = 0; i < n; i++) {
            for(int j = i + 1; j <= n; j++) {
                if (isUnique(s, i , j)) {
                    res = Math.max(j-i, res);
                }
            }
        }

        return res;
    }

    private boolean isUnique(String s, int start, int end) {
        Set<Character> charSet = new HashSet<>();
        for(int i = start; i < end; i++) {
            Character c = s.charAt(i);
            if(charSet.contains(c)) {
                return false;
            }
            charSet.add(c);
        }
        return true;
    }
}

// Solution 2: Sliding Window
// Algorithm
// The naive approach is very straightforward. But it is too slow. So how can we optimize it?
// In the naive approaches, we repeatedly check a substring to see if it has duplicate character. But it is unnecessary. If a substring s_{ij} from index i to j - 1 is already checked to have no duplicate characters. We only need to check if s[j] is already in the substring s_{ij}
// To check if a character is already in the substring, we can scan the substring, which leads to an O(n^2)algorithm. But we can do better.
// By using HashSet as a sliding window, checking if a character in the current can be done in O(1).
// A sliding window is an abstract concept commonly used in array/string problems. A window is a range of elements in the array/string which usually defined by the start and end indices, i.e. [i, j) (left-closed, right-open). A sliding window is a window "slides" its two boundaries to the certain direction. For example, if we slide [i, j) to the right by 1 element, then it becomes [i+1, j+1) (left-closed, right-open).
// Back to our problem. We use HashSet to store the characters in current window [i, j)(j = i initially). Then we slide the index j to the right. If it is not in the HashSet, we slide j further. Doing so until s[j] is already in the HashSet. At this point, we found the maximum size of substrings without duplicate characters start with index i. If we do this for all i, we get our answer.
//
// TimeComplexity: O(2n) = O(n), in worst case, each character will be visit twice
// SpaceComplexity: O(min(m,n)) = O(k), i is the size of set. n is the size of string.length. m is the size of charset/alphabet.
public class Solution {
    public int lengthOfLongestSubstring(String s) {
        int n = s.length();
        Set<Character> set = new HashSet<>();
        int ans = 0, i = 0, j = 0;
        while (i < n && j < n) {
            // try to extend the range [i, j]
            if (!set.contains(s.charAt(j))){
                set.add(s.charAt(j++));
                ans = Math.max(ans, j - i);
            }
            else {
                set.remove(s.charAt(i++));
            }
        }
        return ans;
    }
}