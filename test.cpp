#include <iostream>
#include <sstream>
#include <string>
#include <queue>
#include <cmath>
#include <climits>
#include <set>
#include <stack>
#include <complex>
#include <cstring>
#include <vector>
#include <unordered_map>
#include <iomanip>

using namespace std;

int main(){
    double pi = 3.1415926;
    complex<double> w1(0,pi/3);
    complex<double> w2=exp(w1);

    vector<complex<double> > w(6);
    w[0] = 1;
    w[1] = w2;
    for(int i = 2; i < w.size(); i++){
        w[i] = pow(w2,i);
    }

    complex<double> a0(2,0);
    complex<double> a1(4,0);
    complex<double> a2(3,0);

    vector<complex<double> > y(6);
    for(int i = 0; i < y.size(); i++){
        y[i] = a0 + a1*w[i] + a2*w[i]*w[i];
        cout << y[i];
    }
    cout << endl;

    complex<double> b0(3,0);
    complex<double> b1(5,0);
    complex<double> b2(3,0);
    complex<double> b3(2,0);

    vector<complex<double> > z(6);
    for(int i = 0; i < z.size(); i++){
        z[i] = b0 + b1*w[i] + b2*w[i]*w[i] + b3*w[i]*w[i]*w[i];
        cout << z[i];
    }
    cout << endl;

    vector<complex<double> > yz(6);
    for(int i = 0; i < yz.size(); i++){
        yz[i] = y[i]*z[i];
        cout << yz[i];
    }
    cout << endl;

    vector<complex<double> > c(6);
    complex<double> n(6,0);
    for(int i = 0; i < c.size(); i++){
        complex<double> yzsum(0,0);
        for(int j = 0; j < yz.size(); j++){
            yzsum += yz[j]/pow(w[i],j);
        }
        c[i] = yzsum/n;
        cout << c[i];
    }
    cout << endl;


    return 0;
}