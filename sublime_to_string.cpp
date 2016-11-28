#include <iostream>
#include <sstream>
#include <string>

using namespace std;

namespace patch
{
    template < typename T > std::string to_string( const T& n )
    {
        std::ostringstream stm ;
        stm << n ;
        return stm.str() ;
    }
}

int main()
{
	int n = 5;
	string res = "1";
    while (--n) {
        string cur = "";
        for (int i = 0; i < res.size(); i++) {
            int count = 1;
             while ((i + 1 < res.size()) && (res[i] == res[i + 1])){
                count++; 
                cout << "count: " << count << endl;   
                i++;
                cout << "i: " << i << endl;
            }
            cur += (patch::to_string(count) + res[i]);
            cout << "cur: " << cur << endl;
            
        }
        res = cur;
        cout << "res: " << res << endl;
    }

    return 0;
}

