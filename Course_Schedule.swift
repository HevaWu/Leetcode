/*
There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
Return true if you can finish all courses. Otherwise, return false.

 

Example 1:

Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: There are a total of 2 courses to take. 
To take course 1 you should have finished course 0. So it is possible.
Example 2:

Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
Output: false
Explanation: There are a total of 2 courses to take. 
To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
 

Constraints:

1 <= numCourses <= 105
0 <= prerequisites.length <= 5000
prerequisites[i].length == 2
0 <= ai, bi < numCourses
All the pairs prerequisites[i] are unique.
*/

/*
Solution 3:
optimize Solution 2 by using hashMap for graph part
*/
class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var graph = [Int: [Int]]()
        
        for list in prerequisites {
            graph[list[1], default: [Int]()].append(list[0])
        }
        
        var visited = Array(repeating: 0, count: numCourses)
        for i in 0..<numCourses {
            if !noCycle(graph, i, &visited, numCourses) {
                return false
            }
        }
        return true
    }
    
    // return false if exsit cycle
    // return true if not exist cycle
    func noCycle(_ graph: [Int: [Int]], _ course: Int, 
                    _ visited: inout [Int], _ numCourses: Int ) -> Bool {
        if visited[course] == 1 { return false }
        if visited[course] == 2 { return true }
        
        // under checking
        visited[course] = 1
        if let list = graph[course] {
            for next in list {
                if !noCycle(graph, next, &visited, numCourses) {
                    return false
                }
            }   
        }
        
        // no cycle for course, mark it as 2 means checking DONE
        visited[course] = 2
        return true
    }
}

/*
Solution 2:
dfs

use visited to check if this node checking before:
- visited = 0, not checked yet
- visited = 1, this node is under checkings
- visited = 2, this node is checked, and it is safe

Time Complexity: O(n)
Space Complexity: O(n*n)
*/
class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var graph = Array(repeating: Array(repeating: false, count: numCourses),
                         count: numCourses)
        
        for i in 0..<prerequisites.count {
            let course = prerequisites[i][0]
            let pre = prerequisites[i][1]
            graph[pre][course] = true
        }
        
        var visited = Array(repeating: 0, count: numCourses)
        for i in 0..<numCourses {
            if !noCycle(graph, i, &visited, numCourses) {
                return false
            }
        }
        return true
    }
    
    // return false if exsit cycle
    // return true if not exist cycle
    func noCycle(_ graph: [[Bool]], _ course: Int, 
                    _ visited: inout [Int], _ numCourses: Int ) -> Bool {
        if visited[course] == 1 { return false }
        if visited[course] == 2 { return true }
        
        // under checking
        visited[course] = 1
        for i in 0..<numCourses {
            if graph[course][i] {
                if !noCycle(graph, i, &visited, numCourses) {
                    return false
                }
            }
        }
        
        // no cycle for course, mark it as 2 means checking DONE
        visited[course] = 2
        return true
    }
}

/*
Solution 1:
bfs

build prerequisites graph[pre][course]
use courses[] to memo courseNo's prerequisites

start from check no prerequisites course
wait until searching finished,
if count != numCourses, there is a circle exists

Time Complexity: O(n)
Space Complexity: O(n*n)
*/
class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var graph = Array(repeating: Array(repeating: 0, count: numCourses),
                         count: numCourses)
        var courses = Array(repeating: 0, count: numCourses)
        
        for i in 0..<prerequisites.count {
            let course = prerequisites[i][0]
            let pre = prerequisites[i][1]
            if graph[pre][course] == 0 {
                courses[course] += 1
            }
            graph[pre][course] = 1
        }
        
        var count = 0
        var queue = [Int]()
        for i in 0..<numCourses {
            if courses[i] == 0 {
                queue.append(i)
            }
        }
        
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            count += 1
            
            for i in 0..<numCourses {
                if graph[cur][i] != 0 {
                    courses[i] -= 1
                    if courses[i] == 0 {
                        queue.append(i)
                    }
                }
            }
        }
        
        return count == numCourses
    }
}