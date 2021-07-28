/*
Given a string num representing the digits of a very large integer and an integer k.

You are allowed to swap any two adjacent digits of the integer at most k times.

Return the minimum integer you can obtain also as a string.



Example 1:


Input: num = "4321", k = 4
Output: "1342"
Explanation: The steps to obtain the minimum integer from 4321 with 4 adjacent swaps are shown.
Example 2:

Input: num = "100", k = 1
Output: "010"
Explanation: It's ok for the output to have leading zeros, but the input is guaranteed not to have any leading zeros.
Example 3:

Input: num = "36789", k = 1000
Output: "36789"
Explanation: We can keep the number without any swaps.
Example 4:

Input: num = "22", k = 22
Output: "22"
Example 5:

Input: num = "9438957234785635408", k = 23
Output: "0345989723478563548"


Constraints:

1 <= num.length <= 30000
num contains digits only and doesn't have leading zeros.
1 <= k <= 10^9
*/

/*
Solution 1:
Segment Tree

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func minInteger(_ num: String, _ k: Int) -> String {
        var pqs = Array(repeating: [Int](), count: 10)

        let n = num.count
        var num = num.map { $0.wholeNumberValue! }
        for i in 0..<n {
            pqs[num[i]].append(i)
        }

        var k = k
        var res = String()
        var seg = SegmentTree(n)
        for i in 0..<n {
            // try to place 0...9 in each pos

            for digit in 0...9 {
                if !pqs[digit].isEmpty {
                    let pos = pqs[digit].first!
                    let shift = seg.getCountLessThan(pos)
                    if pos-shift <= k {
                        k -= (pos-shift)
                        seg.add(pos)
                        pqs[digit].removeFirst()
                        res.append(String(digit))
                        break
                    }
                }
            }
        }
        return res
    }
}

class SegmentTree {
    var nodes = [Int]()
    var n = 0

    init(_ n: Int) {
        self.n = n
        nodes = Array(repeating: 0, count: 4*n)
    }

    func add(_ num: Int) {
        insert(num, 0, n, 0)
    }

    func insert(_ num: Int, _ l: Int, _ r: Int, _ node: Int) {
        if num < l || num > r { return }
        if l == r {
            nodes[node] += 1
            return
        }
        let mid = (l+r)/2
        insert(num, l, mid, 2*node + 1)
        insert(num, mid+1, r, 2*node + 2)
        nodes[node] = nodes[2*node+1] + nodes[2*node + 2]
    }

    func getCountLessThan(_ num: Int) -> Int {
        return get(0, num, 0, n, 0)
    }

    func get(_ ql: Int, _ qr: Int, _ l: Int, _ r: Int, _ node: Int) -> Int {
        if qr < l || ql > r { return 0 }
        if ql <= l, qr >= r { return nodes[node] }
        let mid = (l+r)/2
        return get(ql, qr, l, mid, 2*node+1) + get(ql, qr, mid+1, r, 2*node + 2)
    }
}