class Solution {
    func rangeBitwiseAnd(_ left: Int, _ right: Int) -> Int {
        if left == right { return 0 }
        var left = left
        var right = right
        var i = 0
        while left != right, i < 32 {
            left >>= 1
            right >>= 1
            i += 1
        }
        return left << i
    }
}
