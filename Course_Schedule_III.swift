/*
There are n different online courses numbered from 1 to n. You are given an array courses where courses[i] = [durationi, lastDayi] indicate that the ith course should be taken continuously for durationi days and must be finished before or on lastDayi.

You will start on the 1st day and you cannot take two or more courses simultaneously.

Return the maximum number of courses that you can take.



Example 1:

Input: courses = [[100,200],[200,1300],[1000,1250],[2000,3200]]
Output: 3
Explanation:
There are totally 4 courses, but you can take 3 courses at most:
First, take the 1st course, it costs 100 days so you will finish it on the 100th day, and ready to take the next course on the 101st day.
Second, take the 3rd course, it costs 1000 days so you will finish it on the 1100th day, and ready to take the next course on the 1101st day.
Third, take the 2nd course, it costs 200 days so you will finish it on the 1300th day.
The 4th course cannot be taken now, since you will finish it on the 3300th day, which exceeds the closed date.
Example 2:

Input: courses = [[1,2]]
Output: 1
Example 3:

Input: courses = [[3,2],[4,3]]
Output: 0


Constraints:

1 <= courses.length <= 104
1 <= durationi, lastDayi <= 104
*/

/*
Solution 4:
optimize solution 3 by using binary search to quick find current maximum duration

Time Complexity: O(n logm)
Space Complexity: O(n) The valid_list can contain at most n courses.
*/
class Solution {
    func scheduleCourse(_ courses: [[Int]]) -> Int {
        let n = courses.count

        // transfer course to [duration, last start time]
        // then sort by its startTime, then duration
        var courses = courses.sorted(by: { first, second -> Bool in
            return first[1] == second[1] ? first[0] < second[0] : first[1] < second[1]
        })

        var valid = [Int]()
        var time = 0

        for c in courses {
            if time + c[0] <= c[1] {
                time += c[0]
                insert(c[0], &valid)
            } else {
                // first check if valid has element or not
                if !valid.isEmpty {
                    var max_duration = valid.last!

                    // remove previous largest duration course, insert current course
                    if max_duration > c[0] {
                        valid.removeLast()
                        time += c[0] - max_duration
                        insert(c[0], &valid)
                    }
                }
            }
        }

        return valid.count
    }

    func insert(_ num: Int, _ arr: inout [Int]) {
        if arr.isEmpty {
            arr.append(num)
            return
        }

        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] < num {
                left = mid + 1
            } else {
                right = mid
            }
        }

        if arr[left] < num {
            arr.insert(num, at: left + 1)
        } else {
            arr.insert(num, at: left)
        }
    }
}

/*
Solution 3:
optimize Solution 2

use extra valid to help recording course we will take

Time complexity : O(n∗m). We iterate over a total of n elements of the courses array. For every element, we can traverse over at most m number of elements. Here, m refers to the final length of the valid_list.
Space complexity : O(n). The valid_list can contain at most n courses.
*/
class Solution {
    func scheduleCourse(_ courses: [[Int]]) -> Int {
        let n = courses.count

        // transfer course to [duration, last start time]
        // then sort by its startTime, then duration
        var courses = courses.sorted(by: { first, second -> Bool in
            return first[1] == second[1] ? first[0] < second[0] : first[1] < second[1]
        })

        var valid = [Int]()
        var time = 0

        for c in courses {
            if time + c[0] <= c[1] {
                time += c[0]
                valid.append(c[0])
            } else {
                // first check if valid has element or not
                if !valid.isEmpty {
                    var max_i = 0

                    // find previous largest duration courses
                    for j in 1..<valid.count {
                        if valid[j] > valid[max_i] {
                            max_i = j
                        }
                    }

                    if valid[max_i] > c[0] {
                        // take i, and remove max_i course
                        time += c[0] - valid[max_i]
                        valid[max_i] = c[0]
                    }
                }
            }
        }

        return valid.count
    }
}

/*
Solution 2:
iterative

Time Limit Exceeded

- If this course can be taken, we update the current time to time + duration_i and also increment the current count value to indicate that one more course has been taken.
- But, if we aren't able to take the current course i.e. time + duration_i > end\_day_i, we can try to take this course by removing some other course from amongst the courses that have already been taken. But, the current course can fit in by removing some other course, only if the duration of the course jth) being removed duration_j  is larger than the current course's duration, duration_i i.e. duration_j > duration_i

Time complexity : O(n^2). We iterate over the count array of size nn once. For every element currently considered, we could scan backwards till the first element, giving O(n^2) complexity. Sorting the count array takes O(nlogn) time for count array.
Space complexity : O(1). Constant extra space is used.
*/
class Solution {
    func scheduleCourse(_ courses: [[Int]]) -> Int {
        let n = courses.count

        // transfer course to [duration, last start time]
        // then sort by its startTime, then duration
        var courses = courses.sorted(by: { first, second -> Bool in
            return first[1] == second[1] ? first[0] < second[0] : first[1] < second[1]
        })

        var time = 0
        var canTake = 0

        for i in 0..<n {
            if time + courses[i][0] <= courses[i][1] {
                time += courses[i][0]
                canTake += 1
            } else {
                var max_i = i
                // find previous largest duration courses
                for j in 0..<i {
                    if courses[j][0] > courses[max_i][0] {
                        max_i = j
                    }
                }
                if courses[max_i][0] > courses[i][0] {
                    // take i, and remove max_i course
                    time += courses[i][0] - courses[max_i][0]
                }

                // this course has been removed, set it as -1 incase later check it again
                courses[max_i][0] = -1
            }
        }

        return canTake
    }
}

/*
Solution 1:
recursive

Time Limit Exceeded

Idea
- sort courses by end day
- schedule(courses, i, time) return maximum number of courses that can be taken starting from ith course
  - try to include the current course in the taken courses. But, this can be done only if time + duration_i < end_day_i Here, duration_i refers to the duration of the ith course and end_day_i refers to the end day of the ith course.
  - If the course can be taken, we increment the number of courses taken and obtain the number of courses that can be taken by passing the updated time and courses' index. i.e. we make the function call schedule(courses, i + 1, time + duration_i). Let's say, we store the number of courses that can be taken by taking the current course in takentaken variable.
  - Further, for every current course, we also leave the current course, and find the number of courses that can be taken thereof. Now, we need not update the time, but we need to update the courses' index. Thus, we make the function call, schedule(courses, i + 1, time). Let's say, we store the count obtained in not\_takennot_taken variable.

Time complexity : O(n∗d). memo array of size nxd is filled once. Here, nn refers to the number of courses in the given courses array and dd refers to the maximum value of the end day from all the end days in the coursescourses array.
Space complexity : O(n∗d). memo array of size nxd is used.
*/
class Solution {
    func scheduleCourse(_ courses: [[Int]]) -> Int {
        let n = courses.count

        // transfer course to [duration, last start time]
        // then sort by its startTime, then duration
        var courses = courses.sorted(by: { first, second -> Bool in
            return first[1] == second[1] ? first[0] < second[0] : first[1] < second[1]
        })

        // [n][courses[n-1][1] + 1] array for recording course, time
        var memo: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: courses[n-1][1] + 1),
            count: n
        )

        return schedule(courses, 0, n, 0, &memo)
    }

    func schedule(_ courses: [[Int]], _ i: Int, _ n: Int, _ time: Int,
                  _ memo: inout [[Int?]]) -> Int {
        if i == n { return 0 }
        if let val = memo[i][time] { return val }

        var canTake = 0
        if time + courses[i][0] <= courses[i][1] {
            canTake = 1 + schedule(courses, i+1, n, time+courses[i][0], &memo)
        }
        var notTake = schedule(courses, i+1, n, time, &memo)
        memo[i][time] = max(canTake, notTake)
        return memo[i][time]!
    }
}