#include <iostream>
#include <map>
#include <string>

using namespace std;
/*
int transfer(string s) {
    map<char, int> m;
    m['A'] = 1;
    m['M'] = 4;
    m['C'] = 8;
    m['G'] = 25;
    m['R'] = 100;
    int res = m[s[s.length() - 1]];
    for(int i = s.length() - 1; i > 0; i--) {
        if(m[s[i]] > m[s[i-1]]) {
            res -= m[s[i-1]];
        } else {
            res += m[s[i-1]];
        }
    }
    return res;
}*/

int transfer(string s){
    map<char, int> mes;
    mes['A'] = 1;
    mes['M'] = 4;
    mes['C'] = 8;
    mes['G'] = 25;
    mes['R'] = 100;
    int sol = mes[s[s.length()-1]];
    for(int i = s.length()-1; i > 0; i--){
        if(mes[s[i]] > mes[s[i-1]]){  
        //if lower valued character precedes higher valued characer, decrement
            sol -= mes[s[i-1]];
        }
        else{  
            sol += mes[s[i-1]];
        }
    }
    return sol;
}

int main(){
    string s = "GMAM";
    cout << transfer(s);
    return 0;
}
