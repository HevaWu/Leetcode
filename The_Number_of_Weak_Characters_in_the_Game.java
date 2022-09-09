/*
 * You are playing a game that contains multiple characters, and each of the
 * characters has two main properties: attack and defense. You are given a 2D
 * integer array properties where properties[i] = [attacki, defensei] represents
 * the properties of the ith character in the game.
 *
 * A character is said to be weak if any other character has both attack and
 * defense levels strictly greater than this character's attack and defense
 * levels. More formally, a character i is said to be weak if there exists
 * another character j where attackj > attacki and defensej > defensei.
 *
 * Return the number of weak characters.
 *
 *
 *
 * Example 1:
 *
 * Input: properties = [[5,5],[6,3],[3,6]]
 * Output: 0
 * Explanation: No character has strictly greater attack and defense than the
 * other.
 * Example 2:
 *
 * Input: properties = [[2,2],[3,3]]
 * Output: 1
 * Explanation: The first character is weak because the second character has a
 * strictly greater attack and defense.
 * Example 3:
 *
 * Input: properties = [[1,5],[10,4],[4,3]]
 * Output: 1
 * Explanation: The third character is weak because the second character has a
 * strictly greater attack and defense.
 *
 *
 * Constraints:
 *
 * 2 <= properties.length <= 105
 * properties[i].length == 2
 * 1 <= attacki, defensei <= 105
 */

/*
 * Solution 2:
 * greedy
 *
 * sort by increasing attack, decreasing defense
 * then check from end to 0
 * if find element < maxDefense, add it to count
 *
 * Time Complexity: O(nlogn)
 * Space Complexity: O(n)
 */
class Solution {
    public int numberOfWeakCharacters(int[][] properties) {
        Arrays.sort(properties, (p1, p2) -> {
            if (p1[0] == p2[0]) {
                return p2[1] - p1[1];
            } else {
                return p1[0] - p2[0];
            }
        });

        int num = 0;
        int defense = 0;
        for (int i = properties.length - 1; i >= 0; i--) {
            if (properties[i][1] < defense) {
                num += 1;
            } else {
                defense = properties[i][1];
            }
        }

        return num;
    }
}
