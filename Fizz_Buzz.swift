/*
Write a program that outputs the string representation of numbers from 1 to n.

But for multiples of three it should output “Fizz” instead of the number and for the multiples of five output “Buzz”. For numbers which are multiples of both three and five output “FizzBuzz”.

Example:

n = 15,

Return:
[
    "1",
    "2",
    "Fizz",
    "4",
    "Buzz",
    "Fizz",
    "7",
    "8",
    "Fizz",
    "Buzz",
    "11",
    "Fizz",
    "13",
    "14",
    "FizzBuzz"
]
*/

/*
Solution 1
iterative

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func fizzBuzz(_ n: Int) -> [String] {
        return Array(1...n).map { num -> String in
            if num % 3 == 0, num % 5 == 0 {
                return "FizzBuzz"  
            } else if num % 3 == 0 {
                return "Fizz"
            } else if num % 5 == 0 {
                return "Buzz"
            } else {
                return String(num)
            }
        }
    }
}