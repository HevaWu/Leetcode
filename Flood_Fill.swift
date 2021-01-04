/*
An image is represented by a 2-D array of integers, each integer representing the pixel value of the image (from 0 to 65535).

Given a coordinate (sr, sc) representing the starting pixel (row and column) of the flood fill, and a pixel value newColor, "flood fill" the image.

To perform a "flood fill", consider the starting pixel, plus any pixels connected 4-directionally to the starting pixel of the same color as the starting pixel, plus any pixels connected 4-directionally to those pixels (also with the same color as the starting pixel), and so on. Replace the color of all of the aforementioned pixels with the newColor.

At the end, return the modified image.

Example 1:
Input: 
image = [[1,1,1],[1,1,0],[1,0,1]]
sr = 1, sc = 1, newColor = 2
Output: [[2,2,2],[2,2,0],[2,0,1]]
Explanation: 
From the center of the image (with position (sr, sc) = (1, 1)), all pixels connected 
by a path of the same color as the starting pixel are colored with the new color.
Note the bottom corner is not colored 2, because it is not 4-directionally connected
to the starting pixel.
Note:

The length of image and image[0] will be in the range [1, 50].
The given starting pixel will satisfy 0 <= sr < image.length and 0 <= sc < image[0].length.
The value of each color in image[i][j] and newColor will be an integer in [0, 65535].

Hint1:

Write a recursive function that paints the pixel if it's the correct color, then recurses on neighboring pixels.
*/

/*
Solution 1:
recursively, DFS

1. memo oldColor
2. cache visited cell
3. recursively update _floodFill 4 directionally cell

TimeComplexity: O(4n)
SpaceComplexity: O(nm)
*/
class Solution {
    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        guard !image.isEmpty, !image[0].isEmpty else { 
            return image 
        }
        
        let oldColor = image[sr][sc]
        
        let n = image.count
        let m = image[0].count
        
        var res = image
        var visited = Array(repeating: Array(repeating: false, count: m), 
                           count: n)
        
        func _floodFill(_ sr: Int, _ sc: Int) {
            guard sr >= 0, sr < n, sc >= 0, sc < m, 
            res[sr][sc] == oldColor, !visited[sr][sc] else {
                return 
            }
            
            visited[sr][sc] = true
            
             // check color
            if res[sr][sc] != newColor {
                res[sr][sc] = newColor
            }  
            
            _floodFill(sr-1, sc)
            _floodFill(sr+1, sc)
            _floodFill(sr, sc-1)
            _floodFill(sr, sc+1)
        }
        
        _floodFill(sr, sc)
        return res
    }
}