/*
You are playing a game that contains multiple characters, and each of the characters has two main properties: attack and defense. You are given a 2D integer array properties where properties[i] = [attacki, defensei] represents the properties of the ith character in the game.

A character is said to be weak if any other character has both attack and defense levels strictly greater than this character's attack and defense levels. More formally, a character i is said to be weak if there exists another character j where attackj > attacki and defensej > defensei.

Return the number of weak characters.



Example 1:

Input: properties = [[5,5],[6,3],[3,6]]
Output: 0
Explanation: No character has strictly greater attack and defense than the other.
Example 2:

Input: properties = [[2,2],[3,3]]
Output: 1
Explanation: The first character is weak because the second character has a strictly greater attack and defense.
Example 3:

Input: properties = [[1,5],[10,4],[4,3]]
Output: 1
Explanation: The third character is weak because the second character has a strictly greater attack and defense.


Constraints:

2 <= properties.length <= 105
properties[i].length == 2
1 <= attacki, defensei <= 105
*/

/*
Solution 2:
greedy

sort by increasing attack, decreasing defense
then check from end to 0
if find element < maxDefense, add  it to count

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func numberOfWeakCharacters(_ properties: [[Int]]) -> Int {
        // sort by increase attack, decrease defense
        var properties = properties.sorted(by: { p1, p2 -> Bool in
            return p1[0] == p2[0] ? p1[1] > p2[1] : p1[0] < p2[0]
        })

        let n = properties.count
        var defense = 0
        var num = 0

        for i in stride(from: n-1, through: 0, by: -1) {
            if properties[i][1] < defense {
                num += 1
            }
            defense = max(defense, properties[i][1])
        }
        return num
    }
}

/*
Solution 1:
TLE

sort properties by increasing attack, increasing defense
use prev, cur 2 groups to help tracking previous < attack group and current same attack group
update them to get the answer

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func numberOfWeakCharacters(_ properties: [[Int]]) -> Int {
        // sort by increase attack, increase defense
        var properties = properties.sorted(by: { p1, p2 -> Bool in
            return p1[0] == p2[0] ? p1[1] < p2[1] : p1[0] < p2[0]
        })

        // previous strictly less attack's "sorted" defense record
        var prev = [Int]()
        var cur = [properties[0][1]]
        let n = properties.count
        var num = 0

        // print(properties)
        for i in 1..<n {
            if properties[i][0] == properties[i-1][0] {
                cur.append(properties[i][1])
            } else {
                // properties[i][0] > properties[i-1][0]
                num += countWeak(&prev, cur)

                // update prev with cur
                merge(&prev, cur)
                cur = [properties[i][1]]
            }
        }
        num += countWeak(&prev, cur)
        return num
    }

    // return number of weak characters from previous defense
    // also update prev to pop element which less than current maximum defense
    func countWeak(_ prev: inout [Int], _ cur: [Int]) -> Int {
        if cur.isEmpty { return 0 }
        let index = getIndex(prev, cur.last!)
        // print(index, prev, cur)

        // update prev to drop elements which is < target
        prev = Array(prev[(index)...])
        return index
    }

    // merge cur into prev
    func merge(_ prev: inout [Int], _ cur: [Int]) {
        for ele in cur {
            let index = getIndex(prev, ele)
            prev.insert(ele, at: index)
        }
    }

    // return proper min index to insert target into arr
    // also keep arr in increasing order
    func getIndex(_ arr: [Int], _ target: Int) -> Int {
        if arr.isEmpty { return 0 }
        // binary search to find max index in prev which is < target
        var l = 0
        var r = arr.count-1
        while l < r {
            let mid = l + (r-l)/2
            if arr[mid] < target {
                l = mid + 1
            } else {
                r = mid
            }
        }
        return arr[l] < target ? l+1 : l
    }
}
