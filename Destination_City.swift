/*
You are given the array paths, where paths[i] = [cityAi, cityBi] means there exists a direct path going from cityAi to cityBi. Return the destination city, that is, the city without any path outgoing to another city.

It is guaranteed that the graph of paths forms a line without any loop, therefore, there will be exactly one destination city.



Example 1:

Input: paths = [["London","New York"],["New York","Lima"],["Lima","Sao Paulo"]]
Output: "Sao Paulo"
Explanation: Starting at "London" city you will reach "Sao Paulo" city which is the destination city. Your trip consist of: "London" -> "New York" -> "Lima" -> "Sao Paulo".
Example 2:

Input: paths = [["B","C"],["D","B"],["C","A"]]
Output: "A"
Explanation: All possible trips are:
"D" -> "B" -> "C" -> "A".
"B" -> "C" -> "A".
"C" -> "A".
"A".
Clearly the destination city is "A".
Example 3:

Input: paths = [["A","Z"]]
Output: "Z"


Constraints:

1 <= paths.length <= 100
paths[i].length == 2
1 <= cityAi.length, cityBi.length <= 10
cityAi != cityBi
All strings consist of lowercase and uppercase English letters and the space character.
*/

/*
Solution 1:
build graph to store all city, record if it can arrive to another city

Time Complexity: O(n)
- n = paths.count
Space Complexity: O(n)
*/
class Solution {
    func destCity(_ paths: [[String]]) -> String {
        // key the city
        // value, if the city can go to another city
        var graph = [String: Bool]()
        for path in paths {
            graph[path[0]] = true
            if !graph[path[1], default: false] {
                graph[path[1]] = false
            }
        }

        for city in graph.keys {
            if graph[city, default: false] == false {
                // given city cannot go to another city, should be the destination
                return city
            }
        }
        return ""
    }
}
