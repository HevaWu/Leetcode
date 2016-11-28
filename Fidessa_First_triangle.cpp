#include <iostream>

using namespace std;

void isTriangle(int a, int b, int c){
	
int line;
cin >> line;
int a,b,c;
for(int i = 0; i < line; i++) {
	cin >> a;
	cin >> b;
	cin >> c;
	if(a == b && a == c) {

	} else {
		if((a+b>c && a+c>b && b+c>a) && (a==b || a == c || b == c)) {

		} else {
			
		}
	}
}

}

int main(){
	int a=3,b=3,c=3;
	isTriangle(a,b,c);
}