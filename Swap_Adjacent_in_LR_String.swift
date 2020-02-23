// In a string composed of 'L', 'R', and 'X' characters, like "RXXLRXRXL", a move consists of either replacing one occurrence of "XL" with "LX", or replacing one occurrence of "RX" with "XR". Given the starting string start and the ending string end, return True if and only if there exists a sequence of moves to transform one string to the other.

// Example:

// Input: start = "RXXLRXRXL", end = "XRLXXRRLX"
// Output: True
// Explanation:
// We can transform start to end following these steps:
// RXXLRXRXL ->
// XRXLRXRXL ->
// XRLXRXRXL ->
// XRLXXRRXL ->
// XRLXXRRLX
// Note:

// 1 <= len(start) = len(end) <= 10000.
// Both start and end will only consist of characters in {'L', 'R', 'X'}.

// Hint
// Think of the L and R's as people on a horizontal line, where X is a space. The people can't cross each other, and also you can't go from XRX to RXX.

// Solution 1: 
// One invariant is that 'L' and 'R' characters in the string can never cross each other - people walking on the line cannot pass through each other. That means the starting and target strings must be the same when reading only the 'L' and 'R's. With respect to some starting string, let's call such a target string "solid" (since the people don't pass through each other).
// Additionally, the n-th 'L' can never go to the right of it's original position, and similarly the n-th 'R' can never go to the left of it's original position. We'll call this "accessibility". Formally, if (i_1, i_2, \cdots )and (i^{'}_1, i^{'}_2, \cdots )are the positions of each 'L' character in the source and target string, and similarly for (j_i \cdots ), (j^{'}_1 \cdots )and positions of 'R' characters, then we will say a target string is accessible if i_k \geq i^{'}_k and j_k \leq j^{'}_k
// This shows being solid and accessible are necessary conditions. With an induction on the number of people, we can show that they are sufficient conditions. The basic idea of the proof is this: A person on the end either walks away from the others, or walks towards. If they walk away, then let them walk first and it is true; if they walk towards, then let them walk last and it is true (by virtue of the target being solid).
// With these ideas in hand, we'll investigate the two properties individually. If they are both true, then the answer is True, otherwise it is False.
// 
// Time Complexity: O(N)O(N), where NN is the length of start and end.
// Space Complexity: O(N)O(N). The replacement operation is O(N)O(N), while the remaining operations use O(1)O(1) additional space. We could amend the replace part of our algorithm to use pointers so as to reduce the total complexity to O(1)O(1).
class Solution {
    func canTransform(_ start: String, _ end: String) -> Bool {
        // check if LR orders are same, if not, return false
        if start.replacingOccurrences(of: "X", with: "") != end.replacingOccurrences(of: "X", with: "") {
            return false
        }
        
        // start L index will always > end L index
        var indexE = end.startIndex
        for indexS in start.indices {
            if start[indexS] == "L" {
                while end[indexE] != "L" { 
                    indexE = end.index(after: indexE)
                }
                if indexS < indexE {
                    return false
                }
                indexE = end.index(after: indexE)
            }
        }
        
        // start R index will always < end R index
        indexE = end.startIndex
        for indexS in start.indices {
            if start[indexS] == "R" {
                while end[indexE] != "R" {
                    indexE = end.index(after: indexE)
                }
                if indexS > indexE {
                    return false
                }
                indexE = end.index(after: indexE)
            }
        }
        return true
    }
}

// Solution 2: 2 pointers
// We use two pointers to solve it. Each pointer i, j points to an index of start, end with start[i] != 'X', end[j] != 'X'.
// Then, if start[i] != end[j], the target string isn't solid. Also, if start[i] == 'L' and i < j, (or start[i] == 'R' and i > j), the string is not accessible.
// 
// Time Complexity: O(N)O(N), where NN is the length of start and end.
// Space Complexity: O(1)O(1).
class Solution {
    func canTransform(_ start: String, _ end: String) -> Bool {
        var start = Array(start)
        var end = Array(end)
        var n = start.count
        
        var indexS = 0
        var indexE = 0
        while indexS < n, indexE < n {
            while indexS < n, start[indexS] == "X" { indexS += 1 }
            while indexE < n, end[indexE] == "X" { indexE += 1}
            
            // if only one of string finished, then it isn't solid
            if (indexS < n) != (indexE < n) {
                return false
            }
            
            if indexS < n, indexE < n {
                if (start[indexS] != end[indexE])
                || (start[indexS] == "L" && indexS < indexE)
                || (start[indexS] == "R" && indexS > indexE) {
                    return false
                }
            }

            indexS += 1
            indexE += 1
        }
        return true
    }
}


