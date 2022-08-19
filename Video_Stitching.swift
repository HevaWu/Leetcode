/*
You are given a series of video clips from a sporting event that lasted time seconds. These video clips can be overlapping with each other and have varying lengths.

Each video clip is described by an array clips where clips[i] = [starti, endi] indicates that the ith clip started at starti and ended at endi.

We can cut these clips into segments freely.

For example, a clip [0, 7] can be cut into segments [0, 1] + [1, 3] + [3, 7].
Return the minimum number of clips needed so that we can cut the clips into segments that cover the entire sporting event [0, time]. If the task is impossible, return -1.



Example 1:

Input: clips = [[0,2],[4,6],[8,10],[1,9],[1,5],[5,9]], time = 10
Output: 3
Explanation: We take the clips [0,2], [8,10], [1,9]; a total of 3 clips.
Then, we can reconstruct the sporting event as follows:
We cut [1,9] into segments [1,2] + [2,8] + [8,9].
Now we have segments [0,2] + [2,8] + [8,10] which cover the sporting event [0, 10].
Example 2:

Input: clips = [[0,1],[1,2]], time = 5
Output: -1
Explanation: We cannot cover [0,5] with only [0,1] and [1,2].
Example 3:

Input: clips = [[0,1],[6,8],[0,2],[5,6],[0,4],[0,3],[6,7],[1,3],[4,7],[1,4],[2,5],[2,6],[3,4],[4,5],[5,7],[6,9]], time = 9
Output: 3
Explanation: We can take clips [0,4], [4,7], and [6,9].


Constraints:

1 <= clips.length <= 100
0 <= starti <= endi <= 100
1 <= time <= 100
*/

/*
Solution 2:
greedy

clips sort by increasing start time
use i, s, e, to help go through clips

i: index in clips
s: hold the should tracked range of start time
e: hold can picked maximum end time clip's end time

Time Complexity: O(nlogn)
Space Complexity: O(1)
*/
class Solution {
    func videoStitching(_ clips: [[Int]], _ time: Int) -> Int {
        var video = 0
        var clips = clips.sorted(by: { c1, c2 -> Bool in
            return c1[0] < c2[0]
        })

        let n = clips.count

        // start time
        var s = 0
        // end time
        var e = 0

        // index
        var i = 0

        while s < time {
            while i < n, clips[i][0] <= s {
                e = max(e, clips[i][1])
                i += 1
            }

            if s == e { return -1 }

            s = e
            video += 1
        }

        return video
    }

}

/*
Solution 1:
sort + binary search + greedy

sort the clips by start time, then by decreasing end time

always pick longest endtime clip from clips
    // the clip should be in range of
    // - if video.len == 1,
    //    longest end time clip in video[0].start ~ video[0].end
    // - if video.len > 1,
    //    longest end time clip in
    //    video[video.count-2].end ~ video.last.end
    //
    // return nil no more clip have larger end time
    // OR return clip with longest end time in the range\

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func videoStitching(_ clips: [[Int]], _ time: Int) -> Int {
        // sort clips by start time, then by decreasing end time
        var clips = clips.sorted(by: { c1, c2 -> Bool in
            return c1[0] == c2[0]
                ? c1[1] > c2[1]
                : c1[0] < c2[0]
        })

        // the earliest clip cannot cover 0 timestamp
        if clips[0][0] > 0 { return -1 }

        // the picked clips
        var video = [clips[0]]
        while video.last![1] < time {
            if let picked = pick(from: clips, video) {
                video.append(picked)
            } else {
                // cannot find proper picked clip
                return -1
            }
        }

        return video.count
    }

    // try to pick clip from clips
    // the clip should be in range of
    // - if video.len == 1,
    //    longest end time clip in video[0].start ~ video[0].end
    // - if video.len > 1,
    //    longest end time clip in
    //    video[video.count-2].end ~ video.last.end
    //
    // return nil no more clip have larger end time
    // OR return clip with longest end time in the range
    func pick(from clips: [[Int]], _ video: [[Int]]) -> [Int]? {
        let m = video.count
        var s = m == 1 ? video[0][0] : video[m-2][1]
        var e = video[m-1][1]

        // for clips which start in [s...e]
        // find longest end time clip from it

        // clips[index][0] >= s
        var index = findIndex(s, clips)
        var picked = index
        while index < clips.count {
            guard clips[index][0] <= e else { break }
            if clips[index][1] > clips[picked][1] {
                picked = index
            }
            index += 1
        }
        return clips[picked][1] <= e ? nil : clips[picked]
    }

    // return smallest index where clips[index][0] >= s
    func findIndex(_ s: Int, _ clips: [[Int]]) -> Int {
        var l = 0
        var r = clips.count-1
        while l < r {
            let mid = l + (r-l)/2
            if clips[mid][0] < s {
                l = mid+1
            } else {
                r = mid
            }
        }
        return l
    }
}