/*
Given two integers representing the numerator（分子） and denominator（分母） of a fraction, return the fraction in string format.

If the fractional part is repeating, enclose the repeating part in parentheses.

If multiple answers are possible, return any of them.

It is guaranteed that the length of the answer string is less than 104 for all the given inputs.

 

Example 1:

Input: numerator = 1, denominator = 2
Output: "0.5"
Example 2:

Input: numerator = 2, denominator = 1
Output: "2"
Example 3:

Input: numerator = 2, denominator = 3
Output: "0.(6)"
Example 4:

Input: numerator = 4, denominator = 333
Output: "0.(012)"
Example 5:

Input: numerator = 1, denominator = 5
Output: "0.2"
 

Constraints:

-231 <= numerator, denominator <= 231 - 1
denominator != 0
*/

/*
Solution 2
optimize solution 1

we don't need extra FracVal, 
instead, only store index where we might insert "(" would be enough
*/
class Solution {
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        if numerator == 0 { return "0" }
        
        // key is decimal part checked val
        // val is index which we start insert this key's fractorial part
        var map = [Int: Int]()
        
        var isPositive = numerator * denominator > 0
        
        var numerator = abs(numerator)
        var denominator = abs(denominator)
        
        let quotient = numerator / denominator
        var res = String(quotient)
        
        var val = numerator % denominator
        if val == 0 { 
            return isPositive ? res : "-"+res
        }
        
        if !isPositive { res = "-"+res }
        res.append(".")
                
        var frac = [Character]()
        // check decimal part
        while val != 0 {
            if map[val] != nil { break }
            
            var cur = [Character]()
            var temp = val * 10
            while temp < denominator {
                temp *= 10
                cur.append("0")
            }
            
            cur.append(String(temp / denominator).first!)
                        
            map[val] = frac.count
            
            frac.append(contentsOf: cur)
            val = temp % denominator
        }
        
        if val != 0 {
            frac.insert("(", at: map[val]!)
            frac.append(")")
        }
                
        res.append(contentsOf: frac)
        return res
    }
}

/*
Solution 1
iterative
map

1. check isPositive result or not
2. res append numeric part first
3. res append fractorial decimal part
  - use map to store current checked val

Time Complexity: O(t) - t is when numerator/denominator recurring
Space Complexity: O(t)
*/
class Solution {
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        if numerator == 0 { return "0" }
        
        var map = [Int: FracVal]()
        
        var isPositive = numerator * denominator > 0
        
        var numerator = abs(numerator)
        var denominator = abs(denominator)
        
        let quotient = numerator / denominator
        var res = String(quotient)
        
        var val = numerator % denominator
        if val == 0 { 
            return isPositive ? res : "-"+res
        }
        
        if !isPositive { res = "-"+res }
        res.append(".")
        
        // print(val)
        
        var frac = [Character]()
        // check decimal part
        while val != 0 {
            if map[val] != nil { break }
            
            var cur = [Character]()
            var temp = val * 10
            while temp < denominator {
                temp *= 10
                cur.append("0")
            }
            
            let q = temp % denominator
            let v = temp / denominator
            cur.append(String(v).first!)
            
            // print(val, temp, q, v)
            
            map[val] = FracVal(str: cur, q: q, index: frac.count)
            
            frac.append(contentsOf: cur)
            val = q
        }
        
        if val != 0 {
            frac.insert("(", at: map[val]!.index)
            frac.append(")")
        }
        
        // print(frac)
        
        res.append(contentsOf: frac)
        return res
    }
}

struct FracVal {
    // map[4] = FracVal(str: ["0","1"], q: 67, index: )
    // 4/333 = 0.012012
    // q = 67 ((40*10)%333)
    // str = "01" ((40*10)/333)
    // 67/333 = 0.2(012012012)
    // q = 4 (670%333)
    // str = "2"
    
    let str: [Character]
    let q: Int
    
    // index where we insert this frac
    let index: Int
}