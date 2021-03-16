/*
You are given an array of people, people, which are the attributes of some people in a queue (not necessarily in order). Each people[i] = [hi, ki] represents the ith person of height hi with exactly ki other people in front who have a height greater than or equal to hi.

Reconstruct and return the queue that is represented by the input array people. The returned queue should be formatted as an array queue, where queue[j] = [hj, kj] is the attributes of the jth person in the queue (queue[0] is the person at the front of the queue).

 

Example 1:

Input: people = [[7,0],[4,4],[7,1],[5,0],[6,1],[5,2]]
Output: [[5,0],[7,0],[5,2],[6,1],[4,4],[7,1]]
Explanation:
Person 0 has height 5 with no other people taller or the same height in front.
Person 1 has height 7 with no other people taller or the same height in front.
Person 2 has height 5 with two persons taller or the same height in front, which is person 0 and 1.
Person 3 has height 6 with one person taller or the same height in front, which is person 1.
Person 4 has height 4 with four people taller or the same height in front, which are people 0, 1, 2, and 3.
Person 5 has height 7 with one person taller or the same height in front, which is person 1.
Hence [[5,0],[7,0],[5,2],[6,1],[4,4],[7,1]] is the reconstructed queue.
Example 2:

Input: people = [[6,0],[5,0],[4,0],[3,2],[2,2],[1,4]]
Output: [[4,0],[5,0],[2,2],[3,2],[1,4],[6,0]]
 

Constraints:

1 <= people.length <= 2000
0 <= hi <= 106
0 <= ki < people.length
It is guaranteed that the queue can be reconstructed.
*/

/*
Solution 2:

- sort by descending h[i], ascending k[i]
- for each people[i], insert it to people[i][1] would be Okay

Time Complexity: O(nlogn + n)
Space Complexity: O(1)
*/
class Solution {
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        let n = people.count
        if n == 1 { return people }
        
        var people = people.sorted(by: { first, second -> Bool in
            return first[0] == second[0] 
                ? first[1] < second[1] 
                : first[0] > second[0]
        })
        
        for i in 1..<n {
            let cur = people[i]
            if i != cur[1] {
                people.remove(at: i)
                people.insert(cur, at: cur[1])
            }
        }
        
        return people
    }
}

/*
Solution 1:

- sort people by ascending people[i][1](k[i]) then ascending people[i][0](h[i])
- for each k[i] > 0, find a proper position to insert it in 0...i

Time Complexity: O(n^2 + nlogn)
Space Complexity: O(1)
*/
class Solution {
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        let n = people.count
        if n == 1 { return people }
        
        var people = people.sorted(by: { first, second -> Bool in
            return first[1] == second[1] 
                ? first[0] < second[0] 
                : first[1] < second[1]
        })
        
        // print(people)
        
        for i in 1..<n {
            if people[i][1] > 0 {
                let cur = people[i]
                
                // insert it to 0...i
                var j = 0
                var count = 0
                while j < i {
                    if people[j][0] >= cur[0] {
                        count += 1
                    }
                    
                    if count > cur[1] {
                        break
                    }
                    
                    j += 1
                }
                
                // print("inside", j, cur)
                if i == j { continue }
                
                people.remove(at: i)
                people.insert(cur, at: j)
            }
            // print(i, people)
        }
        
        return people
    }
}