/*
Implement the UndergroundSystem class:

void checkIn(int id, string stationName, int t)
A customer with a card id equal to id, gets in the station stationName at time t.
A customer can only be checked into one place at a time.
void checkOut(int id, string stationName, int t)
A customer with a card id equal to id, gets out from the station stationName at time t.
double getAverageTime(string startStation, string endStation)
Returns the average time to travel between the startStation and the endStation.
The average time is computed from all the previous traveling from startStation to endStation that happened directly.
Call to getAverageTime is always valid.
You can assume all calls to checkIn and checkOut methods are consistent. If a customer gets in at time t1 at some station, they get out at time t2 with t2 > t1. All events happen in chronological(时间顺序)order.

 

Example 1:

Input
["UndergroundSystem","checkIn","checkIn","checkIn","checkOut","checkOut","checkOut","getAverageTime","getAverageTime","checkIn","getAverageTime","checkOut","getAverageTime"]
[[],[45,"Leyton",3],[32,"Paradise",8],[27,"Leyton",10],[45,"Waterloo",15],[27,"Waterloo",20],[32,"Cambridge",22],["Paradise","Cambridge"],["Leyton","Waterloo"],[10,"Leyton",24],["Leyton","Waterloo"],[10,"Waterloo",38],["Leyton","Waterloo"]]

Output
[null,null,null,null,null,null,null,14.00000,11.00000,null,11.00000,null,12.00000]

Explanation
UndergroundSystem undergroundSystem = new UndergroundSystem();
undergroundSystem.checkIn(45, "Leyton", 3);
undergroundSystem.checkIn(32, "Paradise", 8);
undergroundSystem.checkIn(27, "Leyton", 10);
undergroundSystem.checkOut(45, "Waterloo", 15);
undergroundSystem.checkOut(27, "Waterloo", 20);
undergroundSystem.checkOut(32, "Cambridge", 22);
undergroundSystem.getAverageTime("Paradise", "Cambridge");       // return 14.00000. There was only one travel from "Paradise" (at time 8) to "Cambridge" (at time 22)
undergroundSystem.getAverageTime("Leyton", "Waterloo");          // return 11.00000. There were two travels from "Leyton" to "Waterloo", a customer with id=45 from time=3 to time=15 and a customer with id=27 from time=10 to time=20. So the average time is ( (15-3) + (20-10) ) / 2 = 11.00000
undergroundSystem.checkIn(10, "Leyton", 24);
undergroundSystem.getAverageTime("Leyton", "Waterloo");          // return 11.00000
undergroundSystem.checkOut(10, "Waterloo", 38);
undergroundSystem.getAverageTime("Leyton", "Waterloo");          // return 12.00000
Example 2:

Input
["UndergroundSystem","checkIn","checkOut","getAverageTime","checkIn","checkOut","getAverageTime","checkIn","checkOut","getAverageTime"]
[[],[10,"Leyton",3],[10,"Paradise",8],["Leyton","Paradise"],[5,"Leyton",10],[5,"Paradise",16],["Leyton","Paradise"],[2,"Leyton",21],[2,"Paradise",30],["Leyton","Paradise"]]

Output
[null,null,null,5.00000,null,null,5.50000,null,null,6.66667]

Explanation
UndergroundSystem undergroundSystem = new UndergroundSystem();
undergroundSystem.checkIn(10, "Leyton", 3);
undergroundSystem.checkOut(10, "Paradise", 8);
undergroundSystem.getAverageTime("Leyton", "Paradise"); // return 5.00000
undergroundSystem.checkIn(5, "Leyton", 10);
undergroundSystem.checkOut(5, "Paradise", 16);
undergroundSystem.getAverageTime("Leyton", "Paradise"); // return 5.50000
undergroundSystem.checkIn(2, "Leyton", 21);
undergroundSystem.checkOut(2, "Paradise", 30);
undergroundSystem.getAverageTime("Leyton", "Paradise"); // return 6.66667
 

Constraints:

There will be at most 20000 operations.
1 <= id, t <= 106
All strings consist of uppercase and lowercase English letters, and digits.
1 <= stationName.length <= 10
Answers within 10-5 of the actual value will be accepted as correct.
*/

/*
Solution 1:
map

Idea:
- build checkInMap for storing all id, check in history
- build stationMap for storing all [startStation endStation] record
- checkIn() only update checkInMap
- checkOut() read existing checkIn record, and store station record in stationMap, clear old id checkIn record
- getAverageTime(), read startStation endStation in stationMap, output result

Time Complexity: 
- checkIn(): O(1)
- checkOut(): O(1)
- getAverageTime(): O(1)

Space Complexity: O(id.count + startStationEndStationPair.count)
*/
class UndergroundSystem {
    // key is customer id
    // value is CheckInStation list, 
    // once this id checkOut, clear it
    var checkInMap = [Int: CheckInStation]()
    
    // key is startStation + * + endStation
    // value is [sum of diff, count]
    var stationMap = [String: [Int]]()
    
    init() {
        
    }
    
    func checkIn(_ id: Int, _ stationName: String, _ t: Int) {
        checkInMap[id] = CheckInStation(name: stationName, time: t)
    }
    
    func checkOut(_ id: Int, _ stationName: String, _ t: Int) {
        guard let station = checkInMap[id] else { return }
        let key = station.name + "#" + stationName
        if let val = stationMap[key] {
            stationMap[key] = [val[0]+(t-station.time), val[1]+1]
        } else {
            stationMap[key] = [t-station.time, 1]
        }
        checkInMap[id] = nil
    }
    
    func getAverageTime(_ startStation: String, _ endStation: String) -> Double {
        let key = startStation + "#" + endStation
        if let val = stationMap[key] {
            return Double(round(Double(val[0])/Double(val[1]) * 100000) / 100000)
        } else {
            return Double(0)
        }
    }
}

struct CheckInStation {
    let name: String
    let time: Int
}

/**
 * Your UndergroundSystem object will be instantiated and called as such:
 * let obj = UndergroundSystem()
 * obj.checkIn(id, stationName, t)
 * obj.checkOut(id, stationName, t)
 * let ret_3: Double = obj.getAverageTime(startStation, endStation)
 */