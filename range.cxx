/*
  Written 2012 Hal Canary.
  This file dedicated to the public domain.

  compile with:
     c++ -o range range.cxx -std=c++0x
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
