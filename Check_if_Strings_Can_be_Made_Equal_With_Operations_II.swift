class Solution {
    func checkStrings(_ s1: String, _ s2: String) -> Bool {
        var oddArr1 = [Character]()
        var oddArr2 = [Character]()
        var evenArr1 = [Character]()
        var evenArr2 = [Character]()

        var isEven = true
        for c in s1 {
            if isEven {
                evenArr1.append(c)
            } else {
                oddArr1.append(c)
            }
            isEven = !isEven
        }
        isEven = true
        for c in s2 {
            if isEven {
                evenArr2.append(c)
            } else {
                oddArr2.append(c)
            }
            isEven = !isEven
        }

        return oddArr1.sorted() == oddArr2.sorted() && evenArr1.sorted() == evenArr2.sorted()
    }
}
