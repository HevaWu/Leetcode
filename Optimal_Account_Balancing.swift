// A group of friends went on holiday and sometimes lent each other money. For example, Alice paid for Bill's lunch for $10. Then later Chris gave Alice $5 for a taxi ride. We can model each transaction as a tuple (x, y, z) which means person x gave person y $z. Assuming Alice, Bill, and Chris are person 0, 1, and 2 respectively (0, 1, 2 are the person's ID), the transactions can be represented as [[0, 1, 10], [2, 0, 5]].

// Given a list of transactions between a group of people, return the minimum number of transactions required to settle the debt.

// Note:

// A transaction will be given as a tuple (x, y, z). Note that x ≠ y and z > 0.
// Person's IDs may not be linear, e.g. we could have the persons 0, 1, 2 or we could also have the persons 0, 2, 6.
// Example 1:

// Input:
// [[0,1,10], [2,0,5]]

// Output:
// 2

// Explanation:
// Person #0 gave person #1 $10.
// Person #2 gave person #0 $5.

// Two transactions are needed. One way to settle the debt is person #1 pays person #0 and #2 $5 each.
// Example 2:

// Input:
// [[0,1,10], [1,0,1], [1,2,5], [2,0,5]]

// Output:
// 1

// Explanation:
// Person #0 gave person #1 $10.
// Person #1 gave person #0 $1.
// Person #1 gave person #2 $5.
// Person #2 gave person #0 $5.

// Therefore, person #1 only need to give person #0 $4, and all debt is settled.

// Solution1: NP-complete, DFS
// With all the given transactions, in the end, each person with ID = id will have an overall balance bal[id]. Note that the id value or any person coincidentally with 0 balance is irrelevant to debt settling count, so we can simply use an array debt[] to store all non-zero balances, where
// debt[i] > 0 means a person needs to pay $ debt[i] to other person(s);
// debt[i] < 0 means a person needs to collect $ debt[i] back from other person(s).
// Starting from first debt debt[0], we look for all other debts debt[i] (i>0) which have opposite sign to debt[0]. Then each such debt[i] can make one transaction debt[i] += debt[0] to clear the person with debt debt[0]. From now on, the person with debt debt[0] is dropped out of the problem and we recursively drop persons one by one until everyone's debt is cleared meanwhile updating the minimum number of transactions during DFS.
// 
// Note: Thanks to @KircheisHe who found the following great paper about the debt settling problem:
// Settling Multiple Debts Efficiently: An Invitation to Computing Science by T. Verhoeff, June 2003.
// The question can be transferred to a 3-partition problem, which is NP-Complete.
// 
// Time complexity: O(n) n is number of person 
// Space complexity: O(2n)
class Solution {
    var debt = [Int]()
    func minTransfers(_ transactions: [[Int]]) -> Int {
        // key is person id
        // value is money he/she need to pay(>0) or collect(<0)
        var map = [Int: Int]()
        
        for transaction in transactions {
            map[transaction[0], default: 0] -= transaction[2]
            map[transaction[1], default: 0] += transaction[2]
        }
        debt = Array(map.values)
        return check(0)
    }
    
    func check(_ start: Int) -> Int {
        var start = start
        while start < debt.count, debt[start] == 0 {
            start += 1
        }
        if start == debt.count { return 0 }
        var transfer = Int.max
        for i in (start+1)..<debt.count {
            if debt[i]*debt[start] < 0 {
                // one person could give another one money
                debt[i] = debt[i]+debt[start]
                transfer = min(transfer, 1+check(start+1))
                debt[i] = debt[i]-debt[start]
            }
        }
        return transfer == Int.max ? 0 : transfer
    }
}