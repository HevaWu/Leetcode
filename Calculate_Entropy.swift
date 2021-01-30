/*
Given a group of values, the entropy of the group is defined as the formula as following:



where P(x) is the probability of appearance for the value x.

The exercise is to calculate the entropy of a group. Here is one example.

the input group:  [1, 1, 2, 2]

the probability of value 1 is  2/4 = 1/2
the probability of value 2 is  2/4 = 1/2

As a result, its entropy can be obtained by:  - (1/2) * log2(1/2) - (1/2) * log2(1/2) = 1/2 + 1/2 = 1

Note: the precision of result would remain within 1e-6.
*/

class Solution {
    func calculateEntropy(_ input: [Int]) -> Double {        
        let n = Double(input.count)
        
        // key is num
        // value is appear times
        var map = [Int: Int]()
        
        for i in input {
            map[i, default: 0] += 1
        }
        
        var res: Double = 0
                
        for k in map.keys {
            let p = Double(map[k]!)/n
            res += (p * log2(p))
        }
        
        return -res
    }
}