// A game on an undirected graph is played by two players, Mouse and Cat, who alternate turns.

// The graph is given as follows: graph[a] is a list of all nodes b such that ab is an edge of the graph.

// Mouse starts at node 1 and goes first, Cat starts at node 2 and goes second, and there is a Hole at node 0.

// During each player's turn, they must travel along one edge of the graph that meets where they are.  For example, if the Mouse is at node 1, it must travel to any node in graph[1].

// Additionally, it is not allowed for the Cat to travel to the Hole (node 0.)

// Then, the game can end in 3 ways:

// If ever the Cat occupies the same node as the Mouse, the Cat wins.
// If ever the Mouse reaches the Hole, the Mouse wins.
// If ever a position is repeated (ie. the players are in the same position as a previous turn, and it is the same player's turn to move), the game is a draw.
// Given a graph, and assuming both players play optimally, return 1 if the game is won by Mouse, 2 if the game is won by Cat, and 0 if the game is a draw.

 

// Example 1:

// Input: [[2,5],[3],[0,4,5],[1,4,5],[2,3],[0,2,3]]
// Output: 0
// Explanation:
// 4---3---1
// |   |
// 2---5
//  \ /
//   0
 

// Note:

// 3 <= graph.length <= 50
// It is guaranteed that graph[1] is non-empty.
// It is guaranteed that graph[2] contains a non-zero element. 

// Solution 1: 
// The state of the game can be represented as (m, c, t) where m is the location of the mouse, c is the location of the cat, and t is 1 if it is the mouse's move, else 2. Let's call these states nodes. These states form a directed graph: the player whose turn it is has various moves which can be considered as outgoing edges from this node to other nodes.
// Some of these nodes are already resolved: if the mouse is at the hole (m = 0), then the mouse wins; if the cat is where the mouse is (c = m), then the cat wins. Let's say that nodes will either be colored \small\text{MOUSE}MOUSE, \small\text{CAT}CAT, or \small\text{DRAW}DRAW depending on which player is assured victory.
// As in a standard minimax algorithm, the Mouse player will prefer \small\text{MOUSE}MOUSE nodes first, \small\text{DRAW}DRAW nodes second, and \small\text{CAT}CAT nodes last, and the Cat player prefers these nodes in the opposite order.
// 
// We will color each node marked \small\text{DRAW}DRAW according to the following rule. (We'll suppose the node has node.turn = Mouse: the other case is similar.)
// ("Immediate coloring"): If there is a child that is colored \small\text{MOUSE}MOUSE, then this node will also be colored \small\text{MOUSE}MOUSE.
// ("Eventual coloring"): If all children are colored \small\text{CAT}CAT, then this node will also be colored \small\text{CAT}CAT.
// We will repeatedly do this kind of coloring until no node satisfies the above conditions. To perform this coloring efficiently, we will use a queue and perform a bottom-up percolation:
// Enqueue any node initially colored (because the Mouse is at the Hole, or the Cat is at the Mouse.)
// For every node in the queue, for each parent of that node:
// Do an immediate coloring of parent if you can.
// If you can't, then decrement the side-count of the number of children marked \small\text{DRAW}DRAW. If it becomes zero, then do an "eventual coloring" of this parent.
// All parents that were colored in this manner get enqueued to the queue.
// 
// Proof of Correctness
// Our proof is similar to a proof that minimax works.
// Say we cannot color any nodes any more, and say from any node colored \small\text{CAT}CAT or \small\text{MOUSE}MOUSE we need at most KK moves to win. If say, some node marked \small\text{DRAW}DRAW is actually a win for Mouse, it must have been with > K>K moves. Then, a path along optimal play (that tries to prolong the loss as long as possible) must arrive at a node colored \small\text{MOUSE}MOUSE (as eventually the Mouse reaches the Hole.) Thus, there must have been some transition \small\text{DRAW} \rightarrow \small\text{MOUSE}DRAW→MOUSE along this path.
// If this transition occurred at a node with node.turn = Mouse, then it breaks our immediate coloring rule. If it occured with node.turn = Cat, and all children of node have color \small\text{MOUSE}MOUSE, then it breaks our eventual coloring rule. If some child has color \small\text{CAT}CAT, then it breaks our immediate coloring rule. Thus, in this case node will have some child with \small\text{DRAW}DRAW, which breaks our optimal play assumption, as moving to this child ends the game in > K>K moves, whereas moving to the colored neighbor ends the game in \leq K≤K moves.
// 
// Time Complexity: O(N^3), where NN is the number of nodes in the graph. There are O(N^2) states, and each state has an outdegree of NN, as there are at most NN different moves.
// Space Complexity: O(N^2).
class Solution {
    func catMouseGame(_ graph: [[Int]]) -> Int {
        let n = graph.count
        let DRAW = 0
        let MOUSE = 1
        let CAT = 2
        
        var color = Array(repeating: Array(repeating: [0, 0, 0], count: 50), count: 50)
        var degree = Array(repeating: Array(repeating: [0, 0, 0], count: 50), count: 50)
        
        // degree[node]: number of neutral children of this node
        for m in 0..<n {
            for c in 0..<n {
                degree[m][c][1] = graph[m].count // 1 means this step is mouse
                degree[m][c][2] = graph[c].count // 2 means this step is cat
                for x in graph[c] where x == 0 {
                    // find a hole
                    degree[m][c][2] -= 1
                    break
                }
            }
        }
        
        // queue: the nodes which are colored
        var queue = [[Int]]()
        for i in 0..<n {
            for t in [1, 2] {
                color[0][i][t] = MOUSE
                queue.insert([0, i, t, MOUSE], at: 0)
                if i > 0 {
                    color[i][i][t] = CAT
                    queue.insert([i, i, t, CAT], at: 0)
                }
            }
        }
        
        // bottom up
        while !queue.isEmpty {
            var node = queue.removeLast()
            let i = node[0]
            let j = node[1]
            let t = node[2]
            let c = node[3]
            
            // check parent of this node
            for parent in getParents(graph, i, j, t) {
                let i2 = parent[0]
                let j2 = parent[1]
                let t2 = parent[2]
                
                // if this parent is not colored
                if color[i2][j2][t2] == DRAW {
                    // check if the parent can make a win move
                    if t2 == c {
                        color[i2][j2][t2] = c
                        queue.insert([i2, j2, t2, c], at: 0)
                    } else {
                        degree[i2][j2][t2] -= 1
                        // all children of this parent are colored as losing moves
                        if degree[i2][j2][t2] == 0{
                            color[i2][j2][t2] = 3 - t2
                            queue.insert([i2, j2, t2, 3-t2], at: 0)
                        }
                    }
                }
            }
        }
        return color[1][2][1]
    }
    
    // which node will arrive at (m, c, t)
    func getParents(_ graph: [[Int]], _ m: Int, _ c: Int, _ t: Int) -> [[Int]] {
        var parents = [[Int]]()
        if t == 2 {
            // current is cat moves
            for m1 in graph[m] {
                parents.append([m1, c, 3-t])
            }
        } else {
            // current is mouse moves
            for c1 in graph[c] where c1 > 0 {
                parents.append([m, c1, 3-t])
            }
        }
        return parents
    }
}
