// Given a non-empty array of unique positive integers A, consider the following graph:

// There are A.length nodes, labelled A[0] to A[A.length - 1];
// There is an edge between A[i] and A[j] if and only if A[i] and A[j] share a common factor greater than 1.
// Return the size of the largest connected component in the graph.

 

// Example 1:

// Input: [4,6,15,35]
// Output: 4

// Example 2:

// Input: [20,50,9,63]
// Output: 2

// Example 3:

// Input: [2,3,6,7,4,12,21,39]
// Output: 8

// Note:

// 1 <= A.length <= 20000
// 1 <= A[i] <= 100000

// Solution 2: UF
// union find
// use f*f to decrease how to find the factor
// use array to init UF'ss parent & size, map will increase the time complexity for this case
// time complexity: O(N*sqrt(Max val of A[i]))
class Solution {
    func largestComponentSize(_ A: [Int]) -> Int {
        let n = A.count
        let uf = UF(n)
        
        // key is factor, value is index
        var factorMap = [Int: Int]()
        for (index, value) in A.enumerated() {
            var f = 2
            while f*f <= value {
                if value%f == 0 {
                    if !factorMap.keys.contains(f) {
                        // this factor is not marked
                        factorMap[f] = index
                    } else {
                        // this factor has already checked
                        uf.union(index, factorMap[f]!)
                    }
                    
                    let quotient = value/f
                    if !factorMap.keys.contains(quotient) {
                        factorMap[quotient] = index
                    } else {
                        uf.union(index, factorMap[quotient]!)
                    }
                }
                f += 1
            }
            
            // valud should also be a factor
            if !factorMap.keys.contains(value) {
                factorMap[value] = index
            } else {
                uf.union(index, factorMap[value]!)
            }
        }
        return uf.maxSize
    }
}

class UF {
    var parent: [Int]
    var size: [Int]
    var maxSize = 0
    init(_ n: Int) {
        parent = Array.init(0..<n)
        size = Array.init(repeating: 1, count: n)
    }
    
    func find(_ x: Int) -> Int {
        if x != parent[x] {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }
    
    func union(_ x: Int, _ y: Int) {
        let rx = find(x)
        let ry = find(y)
        if rx != ry {
            parent[rx] = ry
            size[ry] += size[rx]
            maxSize = max(maxSize, size[ry])
        }
    }
}

// Solution 1: 
// find factor first, then connect their root
// time complexity: 
// -- findFactor: O(n^2) n is size of A, 
// -- connect: O(n^3) worst case
class Solution {
    func largestComponentSize(_ A: [Int]) -> Int {
        var factorDic: [Int: Set<Int>] = [:]
        var numDic: [Int: Set<Int>] = [:]
        for i in A {
            setFactor(num: i, factorDic: &factorDic, numDic: &numDic)
        }
        
        var connectedMap = [Int: Set<Int>]()
        // key is num, value is its connected root
        var visited = [Int: Int]()
        for i in A {
            var root = i
            if visited[i] != nil {
                root = visited[i]!
            }
            for f in numDic[i, default: Set()] {
                for n in factorDic[f, default: Set()] {
                    guard i != n else { continue }
                    if visited[n, default: n] != n, visited[n, default: n] != root {
                        let preRoot = root
                        root = visited[n]!
                        visited[i] = root // union 2 tree
                        connectedMap[root, default: Set([root])].formUnion(connectedMap[preRoot, default: Set([preRoot])])
                        connectedMap[preRoot] = nil
                    } else {
                        visited[n] = root
                        connectedMap[root, default: Set([root])].insert(n)
                    }
                }
            }
        }
        
        var maxSize = 0
        for v in connectedMap.values {
            maxSize = max(maxSize, v.count)
        }
        return maxSize
    }
    
    func connect(num: Int, A: inout Set<Int>, factorDic: [Int: Set<Int>], numDic: [Int: Set<Int>]) -> Int {
        if !A.contains(num) { return 0 }
        A.remove(num)
        
        if numDic[num] == nil { return 1 }
        var size = 1
        for factor in numDic[num]! {
            if factorDic[factor] == nil { continue }
            for next in factorDic[factor]! {
                size += connect(num: next, A: &A, factorDic: factorDic, numDic: numDic)
            }
        }
        return size
    }
    
    // numDic: key is number, value is array of factors
    // factorDic: key is factor, value is array of number
    func setFactor(num: Int, factorDic: inout [Int: Set<Int>], numDic: inout [Int: Set<Int>]) {
        if numDic.keys.contains(num) { return }
        let _factor = findFactor(of: num)
        for f in _factor {
            numDic[num, default: Set<Int>()].insert(f)
            factorDic[f, default: Set<Int>()].insert(num)
        }
    }
    
    func findFactor(of num: Int) -> Set<Int> {
        var factor: Set<Int> = []
        _findFactor(of: num, f: 2, factor: &factor)
        return factor
    }
    
    func _findFactor(of num: Int, f: Int, factor: inout Set<Int>) {
        if num == 1 { return }
        if num % f == 0 {
            factor.insert(f)
            _findFactor(of: num/f, f: 2, factor: &factor)
        } else {
            _findFactor(of: num, f: f+1, factor: &factor)
        }
    }
}


