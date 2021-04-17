/*
Given a list of accounts where each element accounts[i] is a list of strings, where the first element accounts[i][0] is a name, and the rest of the elements are emails representing emails of the account.

Now, we would like to merge these accounts. Two accounts definitely belong to the same person if there is some common email to both accounts. Note that even if two accounts have the same name, they may belong to different people as people could have the same name. A person can have any number of accounts initially, but all of their accounts definitely have the same name.

After merging the accounts, return the accounts in the following format: the first element of each account is the name, and the rest of the elements are emails in sorted order. The accounts themselves can be returned in any order.



Example 1:

Input: accounts = [["John","johnsmith@mail.com","john_newyork@mail.com"],["John","johnsmith@mail.com","john00@mail.com"],["Mary","mary@mail.com"],["John","johnnybravo@mail.com"]]
Output: [["John","john00@mail.com","john_newyork@mail.com","johnsmith@mail.com"],["Mary","mary@mail.com"],["John","johnnybravo@mail.com"]]
Explanation:
The first and third John's are the same person as they have the common email "johnsmith@mail.com".
The second John and Mary are different people as none of their email addresses are used by other accounts.
We could return these lists in any order, for example the answer [['Mary', 'mary@mail.com'], ['John', 'johnnybravo@mail.com'],
['John', 'john00@mail.com', 'john_newyork@mail.com', 'johnsmith@mail.com']] would still be accepted.
Example 2:

Input: accounts = [["Gabe","Gabe0@m.co","Gabe3@m.co","Gabe1@m.co"],["Kevin","Kevin3@m.co","Kevin5@m.co","Kevin0@m.co"],["Ethan","Ethan5@m.co","Ethan4@m.co","Ethan0@m.co"],["Hanzo","Hanzo3@m.co","Hanzo1@m.co","Hanzo0@m.co"],["Fern","Fern5@m.co","Fern1@m.co","Fern0@m.co"]]
Output: [["Ethan","Ethan0@m.co","Ethan4@m.co","Ethan5@m.co"],["Gabe","Gabe0@m.co","Gabe1@m.co","Gabe3@m.co"],["Hanzo","Hanzo0@m.co","Hanzo1@m.co","Hanzo3@m.co"],["Kevin","Kevin0@m.co","Kevin3@m.co","Kevin5@m.co"],["Fern","Fern0@m.co","Fern1@m.co","Fern5@m.co"]]


Constraints:

1 <= accounts.length <= 1000
2 <= accounts[i].length <= 10
1 <= accounts[i][j] <= 30
accounts[i][0] consists of English letters.
accounts[i][j] (for j > 0) is a valid email.
*/

/*
Solution 2:
DFS

For each account, draw the edge from the first email to all other emails. Additionally, we'll remember a map from emails to names on the side. After finding each connected component using a depth-first search, we'll add that to our answer.

Time Complexity: O(∑ai logai​), where ai is the length of accounts[i].
 Without the log factor, this is the complexity to build the graph and search for each component. The log factor is for sorting each component at the end.

Space Complexity: O(∑ai)
*/
class Solution {
    func accountsMerge(_ accounts: [[String]]) -> [[String]] {
        var emailToName = [String: String]()

        // email graph
        var graph = [String: [String]]()

        for account in accounts {
            let name = account[0]
            for i in 1..<account.count {
                emailToName[account[i]] = name
                graph[account[i], default: [String]()].append(account[1])
                graph[account[1], default: [String]()].append(account[i])
            }
        }

        // checked email
        var visited = Set<String>()
        var res = [[String]]()
        for email in graph.keys {
            if visited.contains(email) { continue }
            visited.insert(email)

            var stack = [String]()
            stack.append(email)
            var list = [String]()
            while !stack.isEmpty {
                let cur = stack.removeLast()
                list.append(cur)
                if let nextList = graph[cur] {
                    for next in nextList {
                        if !visited.contains(next) {
                            stack.append(next)
                            visited.insert(next)
                        }
                    }
                }
            }
            list.sort()
            list.insert(emailToName[email]!, at: 0)
            res.append(list)
        }

        return res
    }
}

/*
Solution 1:
Disjoint Set Union (DSU)

draw edges between emails if they occur in the same account. For easier interoperability between our DSU template, we will map each email to some integer index by using emailToID. Then, dsu.find(email) will tell us a unique id representing what component that email is in.

Time Complexity: O(AlogA), where A=∑ai, and ai is the length of accounts[i].
If we used union-by-rank, this complexity improves to O(A)O(Aα(A))≈O(A),
where α is the Inverse-Ackermann function.
Space Complexity: O(A), the space used by our DSU structure.
*/
class Solution {
    func accountsMerge(_ accounts: [[String]]) -> [[String]] {
        var dsu = DSU()

        var emailToName = [String: String]()
        var emailToID = [String: Int]()

        var id = 0
        for account in accounts {
            let name = account[0]
            for i in 1..<account.count {
                emailToName[account[i]] = name
                if emailToID[account[i]] == nil {
                    emailToID[account[i]] = id
                    id += 1
                }
                dsu.union(emailToID[account[1]]!, emailToID[account[i]]!)
            }
        }
        // print(emailToName)
        // print(emailToID)

        var res = [Int: [String]]()
        for email in emailToName.keys {
            let index = dsu.find(emailToID[email]!)
            res[index, default: [String]()].append(email)
        }
        for k in res.keys {
            var list = res[k]!.sorted()
            list.insert(emailToName[list[0]]!, at: 0)
            res[k] = list
        }
        return Array(res.values)
    }
}

class DSU {
    var parent: [Int]

    init() {
        parent = Array(0...10000)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) {
        parent[find(x)] = find(y)
    }
}