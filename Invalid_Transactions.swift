/*
A transaction is possibly invalid if:

the amount exceeds $1000, or;
if it occurs within (and including) 60 minutes of another transaction with the same name in a different city.
You are given an array of strings transaction where transactions[i] consists of comma-separated values representing the name, time (in minutes), amount, and city of the transaction.

Return a list of transactions that are possibly invalid. You may return the answer in any order.



Example 1:

Input: transactions = ["alice,20,800,mtv","alice,50,100,beijing"]
Output: ["alice,20,800,mtv","alice,50,100,beijing"]
Explanation: The first transaction is invalid because the second transaction occurs within a difference of 60 minutes, have the same name and is in a different city. Similarly the second one is invalid too.
Example 2:

Input: transactions = ["alice,20,800,mtv","alice,50,1200,mtv"]
Output: ["alice,50,1200,mtv"]
Example 3:

Input: transactions = ["alice,20,800,mtv","bob,50,1200,mtv"]
Output: ["bob,50,1200,mtv"]


Constraints:

transactions.length <= 1000
Each transactions[i] takes the form "{name},{time},{amount},{city}"
Each {name} and {city} consist of lowercase English letters, and have lengths between 1 and 10.
Each {time} consist of digits, and represent an integer between 0 and 1000.
Each {amount} consist of digits, and represent an integer between 0 and 2000.
*/

/*
Solution 1:
check one by one, iterative

- split transactions to [name, time, amount, city]
- use added to help record the transaction index which already put into invalid
- check current transactions, and all its previous transactions

Time Complexity: O(n^2)
Space Complexity: O(nd)
*/
class Solution {
    func invalidTransactions(_ transactions: [String]) -> [String] {
        var trans: [[String]] = transactions.map {
            Array($0.split(separator: ",").map { String($0) })
        }

        var invalid = [String]()

        // record already put into invalid transations' index
        var added = Set<Int>()

        let n = transactions.count
        for i in 0..<n {
            // check amount
            if (Int(trans[i][2]) ?? 0) > 1000 {
                added.insert(i)
                invalid.append(transactions[i])
            }

            let curName = trans[i][0]
            let curTime = Int(trans[i][1]) ?? 0
            let curCity = trans[i][3]
            for j in 0..<i {
                if trans[j][0] == curName,
                trans[j][3] != curCity,
                abs((Int(trans[j][1]) ?? 0) - curTime) <= 60 {
                    if !added.contains(j) {
                        added.insert(j)
                        invalid.append(transactions[j])
                    }
                    if !added.contains(i) {
                        added.insert(i)
                        invalid.append(transactions[i])
                    }
                }
            }
        }

        return invalid
    }
}