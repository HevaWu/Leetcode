class Solution {
    func checkValidString(_ s: String) -> Bool {
        var lmin = 0
        var lmax = 0
        for c in s {
            if c == Character("(") {
                lmin += 1
                lmax += 1
            } else if c == Character(")") {
                lmin -= 1
                lmax -= 1
            } else {
                lmin -= 1
                lmax += 1
            }
            if lmax < 0 { return false }
            lmin = max(0, lmin)
        }
        return lmin == 0
    }
}
