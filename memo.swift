// Swift Memo

// ===== char string =====
var charArr: [Character] = ["a", "b", "c"]
String(charArr) // char array to string
var str: String = "ab c"
Array(str) // change to [Character]() array
str.lowercased() // lower case string
Character("a").asciiValue! // ascii value
Character("a").isLetter // check if char is letter
Character("1").wholeNumberValue
var sub = str.split(separator: " ") // split
a.joined(separator: " ") // join
str.remove(at: index) // remove char at index
String(3, radix: 2) // "11" transfer decimal to binary

// ===== Array =====
Array(repeating: Array(repeating: 0, count: n+1), count: n+1) // [[Int]] Array init
stride(from: 3, through: 0, by: -1) // 3,2,1,0, same as (0...3).reversed()
var arr = [0,1,2,3,4,5]
arr.replaceSubrange(1...2, with: 4...5) // [0, 4, 5, 3, 4, 5] replace sub array
arr.insert(0, at: 0) // [0,0,4,5,3,4,5]
arr.append(contentsOf:)
digits.swapAt(i, j)  // swap
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
abs(-1) // 1
Double(25).squareRoot() // 5