// Swift Memo

// ===== char string =====
var charArr: [Character] = ["a", "b", "c"]
String(charArr) // char array to string
var str: String = "ab c"
Array(str) // change to [Character]() array
Character("a").isUppercase // check if char is upper case
Character("a").isLowercase // check if char is lower case
str.uppercased() // upper case string
str.lowercased() // lower case string
str.startIndex // string first index String.Index
str.endIndex // string end index String.Index
str.index(after: String.Index) // next string index
let a = Character("a").asciiValue! // ascii value
Character(UnicodeScalar(a+1)) // asciiValue to char
Character("a").isLetter // check if char is letter
Character("1").wholeNumberValue // number value
var sub = str.split(separator: " ") // split
sub.joined(separator: " ") // join
str.remove(at: str.startIndex) // remove char at index
String(3, radix: 2) // "11" transfer decimal to binary
var i = str.indices.last! // string indices
i = str.index(before: i) // index before/after
str[str.index(str.startIndex, offsetBy: 2)] // string index str[2]
String("abc").hash // hash return a fixed int value, can be used in a hashTable


// ===== int =====
0^1 // xor 1
1^1  // xor return 0
Int(4).leadingZeroBitCount // leading zero bit count 61
Int(4).bitWidth // 64
Int.init("100", radix: 2) // radix from string, 4
(log10(Double(27)) / log10(Double(3))).truncatingRemainder(dividingBy: 1) // truncatingRemainder to check if there is a decimal part

// ===== Array =====
Array(repeating: Array(repeating: 0, count: n+1), count: n+1) // [[Int]] Array init
stride(from: 3, through: 0, by: -1) // 3,2,1,0, same as (0...3).reversed()
var arr = [0,1,2,3,4,5]
arr.replaceSubrange(1...2, with: 4...5) // [0, 4, 5, 3, 4, 5] replace sub array
arr.insert(0, at: 0) // insert [0,0,4,5,3,4,5]
arr.removeLast(3) // remove last 3 element
arr.append(contentsOf: [2,3,4]) // append contentsOf
arr.swapAt(3, 4)  // swap at index 3 & index 4
arr.reverse() // reverse array
arr.shuffled() // shuffle array
Int.random(in: 1...2) // random element
Double.random(in: Double(1.2)...Double(2.3)) // random in double array
arr.indices // get indices
arr[..<4] + arr[4...].sorted() // subarray
arr.reduce(into: 0) { res, next in //  reduce
    res += next
    print(res)
}
arr.sorted(by: {
    $0 < $1
})
for (i,v) in arr.enumerated() { // enumerate, iterate
    print(i, v)
    // 0,1 1,2 2,3
}
var it = arr.makeIterator() // iterator, type IndexingIterator<[Int]>
it.next()
arr.enumerated().sorted { (first, second) -> Bool in // enumerate, sort
    return first.element == second.element
        ? first.offset < second.offset
        : first.element < second.element
}.map { $0.offset }

// ===== Set =====
set.insert(3) // insert
set.remove(3) // remove
var set1 = Set([1,2,3])
var set2 = Set([2,3,4])
set1.formUnion(set2) // insert set2 elements to set1
var dic: [Int: Set<Int>] = [:]
var set: Set<Int> = [1,2,3]
dic[2, default: Set<Int>()].formUnion(set)

// ===== Dictionary =====
var dic1: [Int: Int] = [:]
dic1[1, default: 0] += 1 // default value

// ===== zip sequence =====
var str1 = "abcwer"
var word = "abeedr"
for (a,b) in zip(str1, word) {
    if a == b {
        print(a) //a b r
    } else {
        print("a: \(a), b: \(b)") // a: c, b: e a: w, b: e a: e, b: d
    }
}

// ===== function variable =====
let test: ((Int, Int) -> Int) = { a, b in
    return a+b
}

// ===== mutating variable =====
func test(a: inout Int) { }
var _a = 0
test(a: &_a)

// ===== math =====

abs(-1) // abs: 1
sin(1)
cos(1)

pow(Double(2), Double(3)) // pow: 8

Double.pi // pi

Double(25).squareRoot() // sqrt: 5
Double(5.5).rounded() // round: 6
Double(5.2).rounded() // round: 5
Double(round(1.666666666 * 1000) / 1000) // round to 3 digits -> 1.667
Double(-3).sign // sign: minus
Double(3).sign // sign: plus
-4.signum // -1 signum: -1 negative, 1 positive, 0

import Darwin
sqrt(4) // sqrt: 2
floor(1.1) // floor: 1
floor(1.9) // floor: 1
ceil(0.1) // ceil: 1
