// Swift Memo

// ===== char string =====
var charArr: [Character] = ["a", "b", "c"]
String(charArr) // char array to string
var str: String = "ab c"
Array(str) // change to [Character]() array
str.lowercased() // lower case string
let a = Character("a").asciiValue! // ascii value
Character(UnicodeScalar(a+1)) // asciiValue to char
Character("a").isLetter // check if char is letter
Character("1").wholeNumberValue
var sub = str.split(separator: " ") // split
a.joined(separator: " ") // join
str.remove(at: index) // remove char at index
String(3, radix: 2) // "11" transfer decimal to binary
var i = str.indices.last! // string indices
i = str.index(before: i) // index before/after

// ===== int =====
0^1 // xor 1
1^1  // xor return 0
Int(4).leadingZeroBitCount // leading zero bit count 61
Int(4).bitWidth // 64

// ===== Array =====
Array(repeating: Array(repeating: 0, count: n+1), count: n+1) // [[Int]] Array init
stride(from: 3, through: 0, by: -1) // 3,2,1,0, same as (0...3).reversed()
var arr = [0,1,2,3,4,5]
arr.replaceSubrange(1...2, with: 4...5) // [0, 4, 5, 3, 4, 5] replace sub array
arr.insert(0, at: 0) // insert [0,0,4,5,3,4,5]
arr.removeLast(3) // remove last 3 element
arr.append(contentsOf:)
digits.swapAt(i, j)  // swap
arr.reverse() // reverse array
arr.indices // get indices
arr[..<4] + arr[4...].sorted() // subarray
arr.reduce(into: 0) { res, next in //  reduce
    res += next
    print(res)
}
arr.sorted(by: {
    $0 < $1
})
var arr = [1, 2, 3]
for (i,v) in arr.enumerated() { // enumerate, iterate
    print(i, v)
    // 0,1 1,2 2,3
}

// ===== Set =====
set.insert(3) // insert
set.remove(3) // remove
set1.formUnion(set2) // insert set2 elements to set1
var dic: [Int: Set<Int>] = [:]
var set: Set<Int> = [1,2,3]
dic[2, default: Set<Int>()].formUnion(set)

// ===== Dictionary =====
var dic: [Int: Int] = [:]
dic[1, default: 0] // default value

// ===== zip sequence =====
var str = "abcwer"
var word = "abeedr"
for (a,b) in zip(str, word) {
    if a == b {
        print(a) //a b r
    } else {
        print("a: \(a), b: \(b)") // a: c, b: e a: w, b: e a: e, b: d
    }
}

// ===== mutating variable =====
func test(a: inout Int) { }
var _a = 0
test(a: &_a)

// ===== math =====

abs(-1) // abs: 1

Double(25).squareRoot() // sqrt: 5
Double(5.5).rounded() // round: 6
Double(5.2).rounded() // round: 5
Double(-3).sign // sign: minus
Double(3).sign // sign: plus
-4.signum // -1 signum: -1 negative, 1 positive, 0 

import Darwin
pow(Double(2), Double(3)) // pow: 8
sqrt(4) // sqrt: 2
floor(1.1) // floor: 1
floor(1.9) // floor: 1
ceil(0.1) // ceil: 1
