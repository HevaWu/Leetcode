/*
841. Keys and Rooms
There are N rooms and you start in room 0.  Each room has a distinct number in 0, 1, 2, ..., N-1, and each room may have some keys to access the next room.

Formally, each room i has a list of keys rooms[i], and each key rooms[i][j] is an integer in [0, 1, ..., N-1] where N = rooms.length.  A key rooms[i][j] = v opens the room with number v.

Initially, all the rooms start locked (except for room 0).

You can walk back and forth between rooms freely.

Return true if and only if you can enter every room.

Example 1:

Input: [[1],[2],[3],[]]
Output: true
Explanation:
We start in room 0, and pick up key 1.
We then go to room 1, and pick up key 2.
We then go to room 2, and pick up key 3.
We then go to room 3.  Since we were able to go to every room, we return true.

Example 2:

Input: [[1,3],[3,0,1],[2],[0]]
Output: false
Explanation: We can't enter the room with number 2.
Note:

1 <= rooms.length <= 1000
0 <= rooms[i].length <= 1000
The number of keys in all rooms combined is at most 3000.
*/


class Solution1 {
    func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
        return canVisitRooms(rooms, holdKeyroom: [0], noKeyroom: Set(Array(1...rooms.count-1)))
    }

    func canVisitRooms(_ rooms: [[Int]], holdKeyroom: Set<Int>, noKeyroom: Set<Int>) -> Bool {
        guard noKeyroom.count > 0 else {
            return true
        }

        var _holdKeyroom = holdKeyroom
        var _noKeyroom = noKeyroom
        for i in noKeyroom {
            // check if we have this key
            if _holdKeyroom.contains(i) {
                _noKeyroom.remove(i)
                _holdKeyroom.insert(i)

                // open the room i, get the key in room i
                for j in rooms[i] {
                    _holdKeyroom.insert(j)
                }
            }
        }

        if _noKeyroom.count == noKeyroom.count, _noKeyroom.count > 0 {
            return false
        } else {
            return canVisitRooms(rooms, holdKeyroom: _holdKeyroom, noKeyroom: _noKeyroom)
        }
    }
}

class Solution2 {
    /// DFS
    func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
        guard !rooms.isEmpty else { return true }

        var allRoom: [Int] = Array.init(repeating: 0, count: rooms.count)
        allRoom[0] = 1

        allRoom = visitRoom(0, rooms: rooms, allRoom: allRoom)

        return !allRoom.contains(0)
    }

    func visitRoom(_ index: Int, rooms: [[Int]], allRoom: [Int]) -> [Int] {
        var _allRoom = allRoom
            for j in rooms[index] {
                if _allRoom[j] == 0 {
                    _allRoom[j] = 1
                    _allRoom = visitRoom(j, rooms: rooms, allRoom: _allRoom)
                }
            }
        return _allRoom
    }
}

print(Solution().canVisitAllRooms([[1],[2],[3],[]]))
