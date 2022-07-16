/*
A k-mirror number is a positive integer without leading zeros that reads the same both forward and backward in base-10 as well as in base-k.

For example, 9 is a 2-mirror number. The representation of 9 in base-10 and base-2 are 9 and 1001 respectively, which read the same both forward and backward.
On the contrary, 4 is not a 2-mirror number. The representation of 4 in base-2 is 100, which does not read the same both forward and backward.
Given the base k and the number n, return the sum of the n smallest k-mirror numbers.



Example 1:

Input: k = 2, n = 5
Output: 25
Explanation:
The 5 smallest 2-mirror numbers and their representations in base-2 are listed as follows:
  base-10    base-2
    1          1
    3          11
    5          101
    7          111
    9          1001
Their sum = 1 + 3 + 5 + 7 + 9 = 25.
Example 2:

Input: k = 3, n = 7
Output: 499
Explanation:
The 7 smallest 3-mirror numbers are and their representations in base-3 are listed as follows:
  base-10    base-3
    1          1
    2          2
    4          11
    8          22
    121        11111
    151        12121
    212        21212
Their sum = 1 + 2 + 4 + 8 + 121 + 151 + 212 = 499.
Example 3:

Input: k = 7, n = 17
Output: 20379000
Explanation: The 17 smallest 7-mirror numbers are:
1, 2, 3, 4, 5, 6, 8, 121, 171, 242, 292, 16561, 65656, 2137312, 4602064, 6597956, 6958596


Constraints:

2 <= k <= 9
1 <= n <= 30
*/

/*
Solution 1:
for each d digit.
generate all possible 2d and 2d-1 base10 palindromic numbers
always keep odd digit number in before, then even digit number
because we only pick first n numbers

for each base10 numbers, check if this number is also baseK mirror number
if so, add it to sum

- generate base 10 palindromic numbers by digit (this will keep order, and make sure to pick first n numbers)
  - check from digit 1, 2, 3, 4, ...
  - by pass d, generate possible  `2d` and `2d-1`  digits number
	  - ex: d = 1, generate digits 1 and digits 2 numbers
	  - d = 2, generate digits 3 and digits 4 numbers
	  - d = 3, generate digits 4, and digits 5 numbers
	  - ...
	- in generate function, use `odd` and `even` array to keep track current odd digits and even digits generated numbers
		- by build `odd` digits array, it can re-use previous `even` array results, ex: `digits 3` can generate from `digits 2`
			- digits 2: 11, 22, 33, 44, ...
			- digits 3: 101, 111, ... , 191, 202, 212, ...
		- by build `even` digits array, it can use `current odd` array results, ex: `digits 4` can generate from `digits 3`
			- digits 3: 101, 111, ... , 191, 202, 212, ...
			- digits 4: 1001, 1111, ... , 1991, 2002, 2112, ...
		- d=1 will be unique, we give the default odd and even array when d=1. It is because d=1 will never use `0` number
- for each base 10 numbers, check if its valid base k mirror number
  - use normal 2 pointer method to check backward and foreword in same time 
  - in the meanwhile, keep track if we find all  `n` numbers

Time Complexity: O(10^d)
- d is largest half digits
Space Complexity: O(2d)
*/
class Solution {
    func kMirror(_ k: Int, _ n: Int) -> Int {
        var d = 1

        // count of remain wait for being found number
        var n = n

        // sum of finded numbers
        var sum = 0

        // odd digits palindromic base10 numbers
        var odd = [Int]()
        // even digits palindromic base10 numbers
        var even = [Int]()

        while n > 0 {
            // check 2d and 2d-1
            // generated palindromic base10 numbers
            genBaseTen(d, &odd, &even)
            let baseTen = odd+even
            // print(baseTen)
            for num in baseTen {
                // check if number is also baseK mirror number
                if checkBaseK(num, k) {
                    sum += num
                    n -= 1
                    if n == 0 { return sum }
                }
            }

            // update d for next searching
            d += 1
        }

        return sum
    }

    // generate palindromic base 10 numbers
    // with 2d and 2d-1 digits
    // return generate number by sorted
    func genBaseTen(_ d: Int,
                    _ odd: inout [Int],
                    _ even: inout [Int]) {
        if d == 1 {
            odd = [1, 2, 3, 4, 5, 6, 7, 8, 9]
            even = [11, 22, 33, 44, 55, 66, 77, 88, 99]
        } else {
            var newOdd = [Int]()
            var newEven = [Int]()

            // half digits at previous even digit number
            let tenHalf = Int(pow(10.0, Double(d-1)))
            let tenD = Int(pow(10.0, Double(d)))
            let tenD1 = Int(pow(10.0, Double(d+1)))

            for num in even {
                // insert i to mid of num
                for i in 0...9 {
                    // generate 2d-1 digits palindromic
                    // base10 numbers
                    // can generate based on previous even array
                    // ex: digit 3 array can
                    // based on digit 2 numbers
                    let tempOdd = num / tenHalf * tenD
                    + i * tenHalf
                    + num % tenHalf
                    newOdd.append(tempOdd)

                    // generate 2d digits palindromic
                    // base10 numbers
                    // can generate based on current odd array
                    // duplicate odd's mid digit
                    let tempEven = num / tenHalf * tenD1
                    + i * tenD
                    + i * tenHalf
                    + num % tenHalf
                    newEven.append(tempEven)
                }
            }

            odd = newOdd
            even = newEven
        }
    }

    // check current base10 number is
    // also a k-mirror number or not
    func checkBaseK(_ num: Int, _ k: Int) -> Bool {
        // convert to base k string
        var str = Array(String(num, radix: k))
        var s = 0
        var e = str.count-1
        while s <= e {
            if str[s] != str[e] {
                return false
            }
            s += 1
            e -= 1
        }
        return true
    }
}