// There are a total of n courses you have to take, labeled from 0 to n-1.

// Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]

// Given the total number of courses and a list of prerequisite pairs, return the ordering of courses you should take to finish all courses.

// There may be multiple correct orders, you just need to return one of them. If it is impossible to finish all courses, return an empty array.

// Example 1:

// Input: 2, [[1,0]] 
// Output: [0,1]
// Explanation: There are a total of 2 courses to take. To take course 1 you should have finished   
//              course 0. So the correct course order is [0,1] .
// Example 2:

// Input: 4, [[1,0],[2,0],[3,1],[3,2]]
// Output: [0,1,2,3] or [0,2,1,3]
// Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both     
//              courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0. 
//              So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3] .
// Note:

// The input prerequisites is a graph represented by a list of edges, not adjacency matrices. Read more about how a graph is represented.
// You may assume that there are no duplicate edges in the input prerequisites.

// Hint
// This problem is equivalent to finding the topological order in a directed graph. If a cycle exists, no topological ordering exists and therefore it will be impossible to take all courses.

// Solution 1: BFS topological sort
// The way DFS would work is that we would consider all possible paths stemming from A before finishing up the recursion for A and moving onto other nodes. All the nodes in the paths stemming from the node A would have A as an ancestor. The way this fits in our problem is, all the courses in the paths stemming from the course A would have A as a prerequisite.
// 
// Initialize a stack S that will contain the topologically sorted order of the courses in our graph.
// Construct the adjacency list using the edge pairs given in the input. An important thing to note about the input for the problem is that a pair such as [a, b] represents that the course b needs to be taken in order to do the course a. This implies an edge of the form b ➔ a. Please take note of this when implementing the algorithm.
// For each of the nodes in our graph, we will run a depth first search in case that node was not already visited in some other node's DFS traversal.
// Suppose we are executing the depth first search for a node N. We will recursively traverse all of the neighbors of node N which have not been processed before.
// Once the processing of all the neighbors is done, we will add the node N to the stack. We are making use of a stack to simulate the ordering we need. When we add the node N to the stack, all the nodes that require the node N as a prerequisites (among others) will already be in the stack.
// Once all the nodes have been processed, we will simply return the nodes as they are present in the stack from top to bottom.
// 
// Time Complexity: O(N)O(N) considering there are NN courses in all. We essentially perform a complete depth first search covering all the nodes in the forest. It's a forest and not a graph because not all nodes will be connected together. There can be disjoint components as well.
// Space Complexity: O(N)O(N), the space utilized by the recursion stack (not the stack we used to maintain the topologically sorted order)

// Solution 2: node indegree
// The first node in the topological ordering will be the node that doesn't have any incoming edges. Essentially, any node that has an in-degree of 0 can start the topologically sorted order. If there are multiple such nodes, their relative order doesn't matter and they can appear in any order.
// 
// 1 Initialize a queue, Q to keep a track of all the nodes in the graph with 0 in-degree.
// 2 Iterate over all the edges in the input and create an adjacency list and also a map of node v/s in-degree.
// 3 Add all the nodes with 0 in-degree to Q.
// 4 The following steps are to be done until the Q becomes empty.
//   1 Pop a node from the Q. Let's call this node, N.
//   2 For all the neighbors of this node, N, reduce their in-degree by 1. If any of the nodes' in-degree reaches 0, add it to the Q.
//   3 Add the node N to the list maintaining topologically sorted order.
//   4 Continue from step 4.1.
// 
// Time Complexity: O(N)O(N) since we process each node exactly once and end up processing the entire graph given to us.
// Space Complexity: O(N)O(N) since we use an intermediate queue data structure to keep all the nodes with 0 in-degree. In the worst case, there won't be any prerequisite relationship and the queue will contain all the vertices initially since all of them will have 0 in-degree.
class Solution {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        // init indegree & map by prerequisites
        var indegree = Array(repeating: 0, count: numCourses)
        var map = [Int: [Int]]()
        for pre in prerequisites {
            if let _ = map[pre[1]] {
                map[pre[1]]!.append(pre[0])
            } else {
                map[pre[1]] = [pre[0]]
            }
            indegree[pre[0]] += 1
        }
        
        var queue = [Int]()
        for (i, ivalue) in indegree.enumerated() {
            if ivalue == 0 {
                queue.insert(i, at: 0)
            }
        }
        
        var orderArr = [Int]()
        while !queue.isEmpty {
            let node = queue.removeLast()
            orderArr.append(node)
            
            if let _ = map[node] {
                for next in map[node]! {
                    indegree[next] -= 1
                    if indegree[next] == 0 {
                        queue.insert(next, at: 0)
                    }
                }
            }    
        }
        
        return orderArr.count == numCourses ? orderArr : [Int]()
    }
}

// optimize up code
class Solution {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var courses = Array(repeating: 0, count: numCourses)
        var graph = [Int: [Int]]()
        
        for list in prerequisites {
            graph[list[1], default: [Int]()].append(list[0])
            courses[list[0]] += 1
        }
        
        var order = [Int]()
        var queue = [Int]()
        for i in 0..<numCourses {
            if courses[i] == 0 {
                queue.append(i)
            }
        }
        
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            order.append(cur)
            
            if let list = graph[cur] {
                for next in list {
                    courses[next] -= 1
                    if courses[next] == 0 {
                        queue.append(next)
                    }
                }
            }
        }
        
        return order.count == numCourses ? order : [Int]()
    }
}

class Solution {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var indegrees = Array(repeating: 0, count: numCourses)
        var adjLists = Array(repeating: [Int](), count: numCourses)
        for prereq in prerequisites {
            adjLists[prereq[1]].append(prereq[0])
            indegrees[prereq[0]] += 1
        }
        var visited = Set<Int>()
        var res = [Int]()
        
        while visited.count != numCourses {
            var currNode = -1
            for i in 0..<numCourses {
                if !visited.contains(i) && indegrees[i] == 0 {
                    currNode = i
                    break
                }
            }
            
            if currNode == -1 {
                return [Int]()
            }
            
            res.append(currNode)
            visited.insert(currNode)
            
            for neighbor in adjLists[currNode] {
                indegrees[neighbor] -= 1
            }
        }
        
        return res
    }
}