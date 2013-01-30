/*
  Written 2012 Hal Canary.
  This file dedicated to the public domain.

  compile with:
     c++ -o range range.cxx -std=c++0x

I just wrote this little class to implement Python's range()
functionality with C++11's range-based for loops. Is there anything
like this in the C++ standard library? If not, why not?
*/
#include <iostream>
struct range {
  struct integer {
    int i;
    integer(int i): i(i) { }
    int operator*() { return this->i; }
    integer & operator++() { ++this->i; return *this; }
    bool operator!=(integer & n) { return this->i != n.i; }
  };
  int init;
  int n;
  range(int init, int n) : init(init), n(n) { }
  range(int n) : init(0), n(n) { }
  integer begin() { return integer(this->init); }
  integer end() { return integer(this->n); }
};
int main(){
  for (int i: range(10))
    std::cout << i << ' ';
  std::cout << '\n';
  for (int i: range(5,15))
    std::cout << i << ' ';
  std::cout << '\n';
}
