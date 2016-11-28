#include <iostream>
#include <stdio.h>
//#include <cstdio.h>

using namespace std;

class A
{
public:
    A(): val_(0){}
    ~A(){}
    
    A(const A& c)
    {
        if (&c != this)
        {
            cout << "Copying\n";
            this->val_ = c.val_;
        }
    }
    
    void SetVal (int v) { this->val_ = v;}
    int GetVal() {return (this ->val_);}
    
private:
    int val_;
};

static void foo(A a)
{
    cout << "foo called\n" ;
    a.SetVal(18);
}

static void bar(A& a)
{
    cout << "bar called\n";
    a.SetVal(22);
}

int main(int , char**)
{
    A a;
    a.SetVal(99);
    cout << "Val starts as " << a.GetVal() <<endl;
    foo(a);
    cout << "After foo, val is "<< a.GetVal() << endl;
    bar(a);
    cout <<"After bar, val is "<<a.GetVal() <<endl;
    return 0;
}