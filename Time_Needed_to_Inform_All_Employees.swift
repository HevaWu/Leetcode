class Solution {
    func numOfMinutes(_ n: Int, _ headID: Int, _ manager: [Int], _ informTime: [Int]) -> Int {
        // graph[i] means the employee's subordinates
        var graph = Array(repeating: [Int](), count: n)
        for i in 0..<n {
            if i != headID {
                graph[manager[i]].append(i)
            }
        }

        var minutes = 0
        check(headID, 0, informTime, graph, &minutes)
        return minutes
    }

    // curMinutes: inform time from headID to index employee
    func check(_ index: Int, _ curMinutes: Int, _ informTime: [Int], _ graph: [[Int]], _ minutes: inout Int) {
        if graph[index].isEmpty {
            minutes = max(minutes, curMinutes)
            return
        }

        for next in graph[index] {
            check(next, curMinutes + informTime[index], informTime, graph, &minutes)
        }
    }
}
