// You are playing the following Bulls and Cows game with your friend: You write down a number and ask your friend to guess what the number is. Each time your friend makes a guess, you provide a hint that indicates how many digits in said guess match your secret number exactly in both digit and position (called "bulls") and how many digits match the secret number but locate in the wrong position (called "cows"). Your friend will use successive guesses and hints to eventually derive the secret number.

// Write a function to return a hint according to the secret number and friend's guess, use A to indicate the bulls and B to indicate the cows. 

// Please note that both secret number and friend's guess may contain duplicate digits.

// Example 1:

// Input: secret = "1807", guess = "7810"

// Output: "1A3B"

// Explanation: 1 bull and 3 cows. The bull is 8, the cows are 0, 1 and 7.
// Example 2:

// Input: secret = "1123", guess = "0111"

// Output: "1A1B"

// Explanation: The 1st 1 in friend's guess is a bull, the 2nd or 3rd 1 is a cow.
// Note: You may assume that the secret number and your friend's guess only contain digits, and their lengths are always equal.

// Solution 1: 2 array
// one for secret 
// one for guess
// use these two to help checking cows
// 
// Time complexity: O(n)
// Space complexity: O(1)
class Solution {
    func getHint(_ secret: String, _ guess: String) -> String {
        var secretArr = Array(repeating: 0, count: 10)
        var guessArr = Array(repeating: 0, count: 10)
        
        var bulls = 0
        var cows = 0
        for i in secret.indices {
            if secret[i] == guess[i] {
                bulls += 1
            } else {
                secretArr[Int(String(secret[i]))!] += 1
                guessArr[Int(String(guess[i]))!] += 1
            }
        }
        
        for i in 0..<10 {
            cows += min(secretArr[i], guessArr[i])
        }
        
        return "\(bulls)A\(cows)B"
    }
}

// Solution 2: optimize one array
// 
// Time complexity: O(n)
// Space complexity: O(1)
class Solution {
    func getHint(_ secret: String, _ guess: String) -> String {
        var bulls = 0
        var cows = 0
        var numArr = Array(repeating: 0, count: 10)
        for i in secret.indices {
            if secret[i] == guess[i] {
                bulls += 1
            } else {
                let s = secret[i].wholeNumberValue!
                let g = guess[i].wholeNumberValue!
                if numArr[s] < 0 {
                    cows += 1
                }
                if numArr[g] > 0 {
                    cows += 1
                }
                numArr[s] += 1
                numArr[g] -= 1
            }
        }
        return "\(bulls)A\(cows)B"
    }
}