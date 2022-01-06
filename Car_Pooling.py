'''
There is a car with capacity empty seats. The vehicle only drives east (i.e., it cannot turn around and drive west).

You are given the integer capacity and an array trips where trip[i] = [numPassengersi, fromi, toi] indicates that the ith trip has numPassengersi passengers and the locations to pick them up and drop them off are fromi and toi respectively. The locations are given as the number of kilometers due east from the car's initial location.

Return true if it is possible to pick up and drop off all passengers for all the given trips, or false otherwise.



Example 1:

Input: trips = [[2,1,5],[3,3,7]], capacity = 4
Output: false
Example 2:

Input: trips = [[2,1,5],[3,3,7]], capacity = 5
Output: true


Constraints:

1 <= trips.length <= 1000
trips[i].length == 3
1 <= numPassengersi <= 100
0 <= fromi < toi <= 1000
1 <= capacity <= 105
'''

'''
Solution 2:
build location array directly,
because from to to is inside [1, 1000]

Time Complexity: O(n)
Space Complexity: O(at most 1000)
'''
class Solution:
    def carPooling(self, trips: List[List[int]], capacity: int) -> bool:
        minLocation = 1000
        maxLocation = 0
        for t in trips:
            minLocation = min(minLocation, t[1])
            maxLocation = max(maxLocation, t[2])
        location = [0 for i in range(maxLocation - minLocation + 1)]
        for t in trips:
            location[t[1] - minLocation] += t[0]
            location[t[2] - minLocation] -= t[0]
        current = 0
        for person in location:
            current += person
            if current > capacity:
                return False
        return True
