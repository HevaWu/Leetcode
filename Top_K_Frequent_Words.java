/*
 * Given an array of strings words and an integer k, return the k most frequent
 * strings.
 *
 * Return the answer sorted by the frequency from highest to lowest. Sort the
 * words with the same frequency by their lexicographical order.
 *
 *
 *
 * Example 1:
 *
 * Input: words = ["i","love","leetcode","i","love","coding"], k = 2
 * Output: ["i","love"]
 * Explanation: "i" and "love" are the two most frequent words.
 * Note that "i" comes before "love" due to a lower alphabetical order.
 * Example 2:
 *
 * Input: words =
 * ["the","day","is","sunny","the","the","the","sunny","is","is"], k = 4
 * Output: ["the","is","sunny","day"]
 * Explanation: "the", "is", "sunny" and "day" are the four most frequent words,
 * with the number of occurrence being 4, 3, 2 and 1 respectively.
 *
 *
 * Constraints:
 *
 * 1 <= words.length <= 500
 * 1 <= words[i].length <= 10
 * words[i] consists of lowercase English letters.
 * k is in the range [1, The number of unique words[i]]
 *
 *
 * Follow-up: Could you solve it in O(n log(k)) time and O(n) extra space?
 */

/*
 * Solution 1:
 * build frequency map
 *
 * Time Complexity: O(nlogn)
 * Space Complexity: O(k)
 */
class Solution {
    public List<String> topKFrequent(String[] words, int k) {
        Map<String, Integer> freq = new HashMap<>();
        for (String word : words) {
            freq.put(word, freq.getOrDefault(word, 0) + 1);
        }

        final int size = freq.size();
        final List<Map.Entry<String, Integer>> list = new ArrayList<>(size);
        list.addAll(freq.entrySet());
        Collections.sort(list, (m1, m2) -> {
            return m1.getValue() == m2.getValue()
                    ? m1.getKey().compareTo(m2.getKey())
                    : m2.getValue().compareTo(m1.getValue());
        });

        List<String> kfreq = new ArrayList<>();
        for (int i = 0; i < k; i++) {
            kfreq.add(list.get(i).getKey());
        }
        return kfreq;
    }
}
