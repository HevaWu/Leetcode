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
    func partitionLabels(_ S: String) -> [Int] {
        var s = Array(S)
        let n = s.count
        
        var last = [Character: Int]()
        for i in 0..<n {
            last[s[i]] = i
        }
        
        var start = 0
        var end = 0
        var parts = [Int]()
        
        for i in 0..<n {
            end = max(end, last[s[i]]!)
            if end == i {
                // find one partition
                parts.append(end-start+1)
                start = i+1
            }
        }
        return parts
    }
}

/*
Solution 1:
find each char's [startIndex, endIndex],
then iteratively merge them, and add result into part

idea:
- iterative s to build map[key: char, value: [startIndex, endIndex]]
- sort map.values for ascending startIndex, ascending endIndex, and save result into list
- iterative list, merge [startIndex, endIndex] if possible, once found one, append (endIndex-startIndex+1) to part

Time Complexity: O(nlogn)
Space Compexitly: O(n)
*/
class Solution {
    func partitionLabels(_ S: String) -> [Int] {
        var s = Array(S)
        
        // key is each letter
        // value is [firstAppearIndex, lastAppearIndex]
        var map = [Character: [Int]]()
        
        for i in 0..<s.count {
            if let val = map[s[i]] {
                map[s[i]] = [val[0], i]
            } else {
                map[s[i]] = [i, i]
            }
        }
        
        var part = [Int]()
        
        // sort elements by ascending s, ascending e 
        var list = map.values.sorted(by: { first, second -> Bool in
            return first[0] == second[0] 
                ? first[1] < second[1]
                : first[0] < second[0]
        })
        // print(list)
        
        // merge list element if possible 
        // and put them in part
        var temp = (start: list[0][0], end: list[0][1])
        for i in 1..<list.count {
            if list[i][0] <= temp.end {
                temp.end = max(temp.end, list[i][1])
            } else {
                part.append(temp.end - temp.start + 1)
                temp = (start: list[i][0], end: list[i][1])
            }
        }

        // append last checking one
        part.append(temp.end - temp.start + 1)   

        return part
    }
}