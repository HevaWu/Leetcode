/*

*/

class Solution {
    func numberOfMatches(_ n: Int) -> Int {
        if n <= 1 { return 0 }
        let match = n/2
        return match + numberOfMatches(n%2==0 ? match : match+1)
    }
}
