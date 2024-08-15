/*
At a lemonade stand, each lemonade costs $5. Customers are standing in a queue to buy from you and order one at a time (in the order specified by bills). Each customer will only buy one lemonade and pay with either a $5, $10, or $20 bill. You must provide the correct change to each customer so that the net transaction is that the customer pays $5.

Note that you do not have any change in hand at first.

Given an integer array bills where bills[i] is the bill the ith customer pays, return true if you can provide every customer with the correct change, or false otherwise.



Example 1:

Input: bills = [5,5,5,10,20]
Output: true
Explanation:
From the first 3 customers, we collect three $5 bills in order.
From the fourth customer, we collect a $10 bill and give back a $5.
From the fifth customer, we give a $10 bill and a $5 bill.
Since all customers got correct change, we output true.
Example 2:

Input: bills = [5,5,10,10,20]
Output: false
Explanation:
From the first two customers in order, we collect two $5 bills.
For the next two customers in order, we collect a $10 bill and give back a $5 bill.
For the last customer, we can not give the change of $15 back because we only have two $10 bills.
Since not every customer received the correct change, the answer is false.


Constraints:

1 <= bills.length <= 105
bills[i] is either 5, 10, or 20.
*/

/*
Solution 1:
Use map to track current pocket bills
Then check if there is sufficient change to return

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func lemonadeChange(_ bills: [Int]) -> Bool {
        // key is bill
        // value is number of that bill
        var pocket = [Int: Int]()
        for bill in bills {
            let change = bill - 5
            if change == 15 {
                let remain10 = pocket[10, default: 0]
                let remain5 = pocket[5, default: 0]
                if (remain10 >= 1 && remain5 >= 1) {
                    // return customer one $10, one $5
                    pocket[10, default: 0] -= 1
                    pocket[5, default: 0] -= 1
                } else if remain5 >= 3 {
                    // return customer three $5
                    pocket[5, default: 0] -= 3
                } else {
                    // cannot find change for customer
                    return false
                }
            } else if change == 5 {
                if pocket[5, default: 0] == 0 {
                    return false
                }
                pocket[5, default: 0] -= 1
            }

            pocket[bill, default: 0] += 1
        }
        return true
    }
}
