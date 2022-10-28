/*
 * Given an array of strings strs, group the anagrams together. You can return
 * the answer in any order.
 *
 * An Anagram is a word or phrase formed by rearranging the letters of a
 * different word or phrase, typically using all the original letters exactly
 * once.
 *
 *
 *
 * Example 1:
 *
 * Input: strs = ["eat","tea","tan","ate","nat","bat"]
 * Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
 * Example 2:
 *
 * Input: strs = [""]
 * Output: [[""]]
 * Example 3:
 *
 * Input: strs = ["a"]
 * Output: [["a"]]
 *
 *
 * Constraints:
 *
 * 1 <= strs.length <= 104
 * 0 <= strs[i].length <= 100
 * strs[i] consists of lower-case English letters.
 */

/*
 * Solution 1:
 * map
 * caterize by sorted string
 *
 * Time Complexity: O(n*slogs)
 * - n is length of strs
 * - k is maximum length of a string in strs
 * Space Complexity: O(ns)
 */
class Solution {
    public List<List<String>> groupAnagrams(String[] strs) {
        Map<String, List<String>> anagram = new HashMap<>();
        for (String str : strs) {
            String key = getKey(str);
            List<String> value = anagram.getOrDefault(key, new ArrayList<>());
            value.add(str);
            anagram.put(key, value);
        }

        List<List<String>> group = new ArrayList<>();
        for (String key : anagram.keySet()) {
            group.add(anagram.get(key));
        }
        return group;
    }

    public String getKey(String str) {
        char charArr[] = str.toCharArray();
        Arrays.sort(charArr);
        return new String(charArr);
    }
}
