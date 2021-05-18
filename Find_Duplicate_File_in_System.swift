/*
Given a list paths of directory info, including the directory path, and all the files with contents in this directory, return all the duplicate files in the file system in terms of their paths. You may return the answer in any order.

A group of duplicate files consists of at least two files that have the same content.

A single directory info string in the input list has the following format:

"root/d1/d2/.../dm f1.txt(f1_content) f2.txt(f2_content) ... fn.txt(fn_content)"
It means there are n files (f1.txt, f2.txt ... fn.txt) with content (f1_content, f2_content ... fn_content) respectively in the directory "root/d1/d2/.../dm". Note that n >= 1 and m >= 0. If m = 0, it means the directory is just the root directory.

The output is a list of groups of duplicate file paths. For each group, it contains all the file paths of the files that have the same content. A file path is a string that has the following format:

"directory_path/file_name.txt"


Example 1:

Input: paths = ["root/a 1.txt(abcd) 2.txt(efgh)","root/c 3.txt(abcd)","root/c/d 4.txt(efgh)","root 4.txt(efgh)"]
Output: [["root/a/2.txt","root/c/d/4.txt","root/4.txt"],["root/a/1.txt","root/c/3.txt"]]
Example 2:

Input: paths = ["root/a 1.txt(abcd) 2.txt(efgh)","root/c 3.txt(abcd)","root/c/d 4.txt(efgh)"]
Output: [["root/a/2.txt","root/c/d/4.txt"],["root/a/1.txt","root/c/3.txt"]]


Constraints:

1 <= paths.length <= 2 * 104
1 <= paths[i].length <= 3000
1 <= sum(paths[i].length) <= 5 * 105
paths[i] consist of English letters, digits, '/', '.', '(', ')', and ' '.
You may assume no files or directories share the same name in the same directory.
You may assume each given directory info represents a unique directory. A single blank space separates the directory path and file info.


Follow up:

Imagine you are given a real file system, how will you search files? DFS or BFS?
If the file content is very large (GB level), how will you modify your solution?
If you can only read the file by 1kb each time, how will you modify your solution?
What is the time complexity of your modified solution? What is the most time-consuming part and memory-consuming part of it? How to optimize?
How to make sure the duplicated files you find are not false positive?
*/

/*
Follow up explain

Very large files and false positives
For very large files we should do the following comparisons in this order:
- compare sizes, if not equal, then files are different and stop here!
- hash them with a fast algorithm e.g. MD5 or use SHA256 (no collisions found yet), if not equal then stop here!
- compare byte by byte to avoid false positives due to collisions.

Have you used an IDE in remote development mode?
For example, CLion has some options on how to compare the local files with the remote server files and then decides to synchronize or not.

Complexity
Runtime - Worst case (which is very unlikely to happen): O(N^2 * L) where L is the size of the maximum bytes that need to be compared
Space - Worst case: all files are hashed and inserted in the hashmap, so O(H^2*L), H is the hash code size and L is the filename size
*/

/*
Solution 1:
map

Time Complexity: O(nk)
Space Complexity: O(nk)
*/
class Solution {
    func findDuplicate(_ paths: [String]) -> [[String]] {
        let n = paths.count

        // key: content
        // val: list of path which have same content
        var map = [String: Set<String>]()

        for path in paths {
            for (p, c) in parsePath(path) {
                map[c, default: Set<String>()].insert(p)
            }
        }

        // only return duplicated one
        return map.values
        .compactMap { $0.count > 1 ? Array($0) : nil }
    }

    func parsePath(_ path: String) -> [(path: String, content: String)] {
        let list = path.split(separator: " ")
        var res = [(path: String, content: String)]()
        let root = list[0]
        for i in 1..<list.count {
            let part = list[i].split(separator: "(")
            // part[0] is .txt file
            // part[1] os xxx) content
            res.append((root+"/"+part[0], String(part[1])))
        }
        return res
    }
}
