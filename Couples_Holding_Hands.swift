// N couples sit in 2N seats arranged in a row and want to hold hands. We want to know the minimum number of swaps so that every couple is sitting side by side. A swap consists of choosing any two people, then they stand up and switch seats.

// The people and seats are represented by an integer from 0 to 2N-1, the couples are numbered in order, the first couple being (0, 1), the second couple being (2, 3), and so on with the last couple being (2N-2, 2N-1).

// The couples' initial seating is given by row[i] being the value of the person who is initially sitting in the i-th seat.

// Example 1:

// Input: row = [0, 2, 1, 3]
// Output: 1
// Explanation: We only need to swap the second (row[1]) and third (row[2]) person.
// Example 2:

// Input: row = [3, 2, 0, 1]
// Output: 0
// Explanation: All couples are already seated side by side.
// Note:

// len(row) is even and in the range of [4, 60].
// row is guaranteed to be a permutation of 0...len(row)-1.

// Solution 1: brute force (time limit exceed)
// check the couples one by one 
// 
// Time complexity: O(n^2)
// Space complexity: O(n)
class Solution {
    func minSwapsCouples(_ row: [Int]) -> Int {
        var count = 0
        
        var row = row
        var i = 0
        while i < row.count-1 {
            let pair = (row[i]%2 == 0) ? row[i]+1 : row[i]-1
            if row[i+1] == pair { 
                // this couple already sit side by side
                i = i+2
                continue
            }
            
            // not sit together, find its pair position and swap it
            var j = i+2
            while j < row.count {
                if row[j] == pair {
                    break
                }
            }
            row.swapAt(i+1, j)
            count += 1
            
            i = i+2
        }
        return count
    }
}

// Solution 2: index tracking
// use position
// use partner
// find until i == partner[position[partner[row[i]]]] 
// 
// The N couples problem can be solved using exactly the same idea as the N integers problem, except now we have different placement requirements: instead of i == row[i], we require i == ptn[pos[ptn[row[i]]]], where we have defined two additional arrays ptn and pos:
// ptn[i] denotes the partner of label i (i can be either a seat or a person) - - ptn[i] = i + 1 if i is even; ptn[i] = i - 1 if i is odd.
// pos[i] denotes the index of the person with label i in the row array - - row[pos[i]] == i.
// The meaning of i == ptn[pos[ptn[row[i]]]] is as follows:
// The person sitting at seat i has a label row[i], and we want to place him/her next to his/her partner.
// So we first find the label of his/her partner, which is given by ptn[row[i]].
// We then find the seat of his/her partner, which is given by pos[ptn[row[i]]].
// Lastly we find the seat next to his/her partner's seat, which is given by ptn[pos[ptn[row[i]]]].
// Therefore, for each pivot index i, its expected index j is given by ptn[pos[ptn[row[i]]]]. As long as i != j, we swap the two elements at index i and j, and continue until the placement requirement is satisfied. A minor complication here is that for each swapping operation, we need to swap both the row and pos arrays.
// Here is a list of solutions for Java and C++. Both run at O(N) time with O(N) space. Note that there are several optimizations we can do, just to name a few:
// The ptn array can be replaced with a simple function that takes an index i and returns i + 1 or i - 1 depending on whether i is even or odd.
// We can check every other seat instead of all seats. This is because we are matching each person to his/her partners, so technically speaking there are always half of the people sitting at the right seats.
// There is an alternative way for building the index groups which goes in backward direction, that is instead of building the cycle like i0 --> i1 --> ... --> jk --> i0, we can also build it like i0 <-- i1 <-- ... <-- ik <-- i0, where i <-- j means the element at index j is expected to appear at index i. In this case, the pivot index will be changing along the cycle as the swapping operations are applied. The benefit is that we only need to do swapping on the row array.
// 
// Time complexity: O(n)
// Space complexity: O(2n)
class Solution {
    func minSwapsCouples(_ row: [Int]) -> Int {
        var count = 0
        
        let n = row.count
        var partner = Array(repeating: 0, count: n)
        var position = Array(repeating: 0, count: n)
        
        for i in 0..<n {
            partner[row[i]] = row[i]%2==0 ? row[i]+1 : row[i]-1
            position[row[i]] = i
        }
        
        var row = row
        for i in 0..<n {
            var j = partner[position[partner[row[i]]]]
            while i != j {
                row.swapAt(i, j)
                position.swapAt(row[i], row[j])
                count += 1
                j = partner[position[partner[row[i]]]]
            }
        }
        return count
    }
}