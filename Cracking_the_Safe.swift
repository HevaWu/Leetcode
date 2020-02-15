// There is a box protected by a password. The password is a sequence of n digits where each digit can be one of the first k digits 0, 1, ..., k-1.

// While entering a password, the last n digits entered will automatically be matched against the correct password.

// For example, assuming the correct password is "345", if you type "012345", the box will open because the correct password matches the suffix of the entered password.

// Return any password of minimum length that is guaranteed to open the box at some point of entering it.

 

// Example 1:

// Input: n = 1, k = 2
// Output: "01"
// Note: "10" will be accepted too.
// Example 2:

// Input: n = 2, k = 2
// Output: "00110"
// Note: "01100", "10011", "11001" will be accepted too.
 

// Note:

// n will be in the range [1, 4].
// k will be in the range [1, 10].
// k^n will be at most 4096.

// Hint
// We can think of this problem as the problem of finding an Euler path (a path visiting every edge exactly once) on the following graph: there are $$k^{n-1}$$ nodes with each node having $$k$$ edges. It turns out this graph always has an Eulerian circuit (path starting where it ends.) We should visit each node in "post-order" so as to not get stuck in the graph prematurely.

// Solution 1: Hierholzer's Algorithm
// whenever there is an Euler cycle, we can construct it greedily. The algorithm goes as follows:
// - Starting from a vertex u, we walk through (unwalked) edges until we get stuck. Because the in-degrees and out-degrees of each node are equal, we can only get stuck at u, which forms a cycle.
// - Now, for any node v we had visited that has unwalked edges, we start a new cycle from v with the same procedure as above, and then merge the cycles together to form a new cycle u \rightarrow \dots \rightarrow v \rightarrow \dots \rightarrow v \rightarrow \dots \rightarrow uu→⋯→v→⋯→v→⋯→u.
// 
// We will modify our standard depth-first search: instead of keeping track of nodes, we keep track of (complete) edges: seen records if an edge has been visited.
// we'll need to visit in a sort of "post-order", recording the answer after visiting the edge. This is to prevent getting stuck. For example, with k = 2, n = 2, we have the nodes '0', '1'. If we greedily visit complete edges '00', '01', '10', we will be stuck at the node '0' prematurely. However, if we visit in post-order, we'll end up visiting '00', '01', '11', '10' correctly.
// we will record the results of other subcycles first, before recording the main cycle we started from, just as in our first description of the algorithm. Technically, we are recording backwards, as we exit the nodes.
// 
// Time Complexity: O(n * k^n). We visit every edge once in our depth-first search, and nodes take O(n)O(n) space.
// Space Complexity: O(n * k^n), the size of seen.
class Solution {
    var pass = String()
    var strSet = Set<String>()
    
    func crackSafe(_ n: Int, _ k: Int) -> String {
        var strArr = String(repeating: "0", count: n-1)
        
        dfs(strArr, k)
        pass.append(String(strArr))
        return pass
    }
    
    func dfs(_ strArr: String, _ k: Int) {
        for i in 0..<k {
            var temp = strArr + String(i)
            if !strSet.contains(temp) {
                strSet.insert(temp)
                dfs(String(temp[temp.index(temp.startIndex, offsetBy: 1)...]), k)
                pass.append(String(i))
            }
        }
    }
}

// Solution 2
// 
// 
class Solution {
    func crackSafe(_ n: Int, _ k: Int) -> String {
        // n = length of the input
        // k = range of characters
       var M = Int(pow(Double(k), Double(n-1))) // The size of the sequence/2
        var P = Array(repeating: 0, count: M*k)
        var A = Array(repeating: 0, count: M*k)

        // for input n = 2, k = 4
        // Creates the array [0, 2, 4, 6, 8, 10, 12, 14, 1, 3, 5, 7, 9, 11, 13, 15]
        //                   [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
            
        for i in 0..<k {// For each possible input value
                for q in 0..<M { // For each possible position that a value can have
                    P[i*M+q] = q*k + i
                    A[i*M+q] = q*k + i + 1
                }   
            }

        var ans = [Character]()
        for i in 0..<M*k {
            var j = i
            while P[j] >= 0 {
                ans.append(Character("\(j/M)"))
                let v = P[j]
                P[j] = -1
                j = v

            }
        }
        for i in 0..<n-1 {
            ans.append("0")
        }
        return String(ans)
    }
}

