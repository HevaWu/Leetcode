/*
Given a list of airline tickets represented by pairs of departure and arrival airports [from, to], reconstruct the itinerary in order. All of the tickets belong to a man who departs from JFK. Thus, the itinerary must begin with JFK.

Note:
If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string. For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
All airports are represented by three capital letters (IATA code).
You may assume all tickets form at least one valid itinerary.
Example 1:
tickets = [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
Return ["JFK", "MUC", "LHR", "SFO", "SJC"].
Example 2:
tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
Return ["JFK","ATL","JFK","SFO","ATL","SFO"].
Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"]. But it is larger in lexical order.
Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Depth-first Search Graph
*/



/*
use hashmap to store tickets array
key is the start airport, value is a priorityqueue to store the end airport
use priorityqueue to keep choose the smallest lexical airport
then start from JFK, search the airport
the return result use a arraylist to store,
through this way, we will get the end airport first, so each time insert the airport in the ret list at position 0, ret.add(0, airport)

First keep going forward until you get stuck. That's a good main path already. 
Remaining tickets form cycles which are found on the way back and get merged into that main path. 
By writing down the path backwards when retreating from recursion, 
merging the cycles into the main path is easy - 
the end part of the path has already been written, 
the start part of the path hasn't been written yet, 
so just write down the cycle now and then keep backwards-writing the path.*/
/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> findItinerary(vector<pair<string, string>> tickets) {
        for(auto tick:tickets){
            airport[tick.first].insert(tick.second);   //insert all the trips into a map
        }
        NextStop("JFK");
        return vector<string>(trip.rbegin(),trip.rend());
    }
    
    map<string, multiset<string>> airport;
    vector<string> trip;
    
    void NextStop(string nstop){
        while(airport[nstop].size()){
            string nnstop = *airport[nstop].begin();
            airport[nstop].erase(airport[nstop].begin());
            NextStop(nnstop);
        }
        trip.push_back(nstop);
    }
};








/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    private Map<String, PriorityQueue<String> > airport = new HashMap<>();
    List<String> trip = new LinkedList<>();
    
    public List<String> findItinerary(String[][] tickets) {
        for(String[] t:tickets){
            airport.putIfAbsent(t[0], new PriorityQueue<>());
            //hashmap.putIfAbsent(key, value) --- if the specified key is not already associated with a value(or is mapped to null), associated it with the given value and returns null, else returns the current value
            airport.get(t[0]).add(t[1]);
        }
        NextStop("JFK");
        return trip;
    }
    
    private void NextStop(String nstop){
        while(airport.containsKey(nstop) && !airport.get(nstop).isEmpty()){
            NextStop(airport.get(nstop).poll());
        }
        trip.add(0, nstop);
    }
}