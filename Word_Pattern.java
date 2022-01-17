/*
Given a pattern and a string s, find if s follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in s.



Example 1:

Input: pattern = "abba", s = "dog cat cat dog"
Output: true
Example 2:

Input: pattern = "abba", s = "dog cat cat fish"
Output: false
Example 3:

Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false


Constraints:

1 <= pattern.length <= 300
pattern contains only lower-case English letters.
1 <= s.length <= 3000
s contains only lowercase English letters and spaces ' '.
s does not contain any leading or trailing spaces.
All the words in s are separated by a single space.
*/

/*
Solution 1
2 maps

wordToLetter
letterToWord

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public boolean wordPattern(String pattern, String s) {
        String[] words = s.split(" ");
        if (pattern.length() != words.length) { return false; }

        Map<String, Character> wordToLetter = new HashMap<>();
        Map<Character, String> letterToWord = new HashMap<>();

        for(int i = 0; i < pattern.length(); i++) {
            char letter = pattern.charAt(i);
            String word = words[i];

            // System.out.println(word);
            // System.out.println(letter);
            // System.out.println(wordToLetter.get(word));
            // System.out.println(letterToWord.get(letter));

            if (wordToLetter.containsKey(word) && wordToLetter.get(word) != letter) {
                System.out.println("wordToLetter here");
                return false;
            }
            if (letterToWord.containsKey(letter) && !letterToWord.get(letter).equals(word)) {
                return false;
            }

            wordToLetter.put(word, letter);
            letterToWord.put(letter, word);
        }
        return true;
    }
}