/*
  Written 2012 Hal Canary.
  This file dedicated to the public domain.

  compile with: "-std=c++0x".  I have found that I need to compile
  with -O2 or better to have the compiler remove the overhead
  associated with this.
*/
#ifndef RANGE_H
#define RANGE_H
/**
   A class to implement Python's range() functionality with C++11's
   range-based for loops.

   Example:
   \code
   #include <iostream>
   #include "Range.h"
   int main(){
     for (int i: Range(10))
       std::cout << i << ' ';
     std::cout << '\n';
     for (auto i: uRange(5,15))
       std::cout << i << ' ';
     std::cout << '\n';
   }
   \endcode
  */
template < typename T >
struct RangeTemplate {
  struct iterator {
    T i;
    iterator(T i): i(i) { }
    T operator*() { return this->i; }
    iterator & operator++() { ++this->i; return *this; }
    bool operator!=(iterator & n) { return this->i != n.i; }
  };
  T init;
  T n;
  RangeTemplate(T init, T n) : init(init), n(n) { }
  RangeTemplate(T n) : init(0), n(n) { }
  iterator begin() { return iterator(this->init); }
  iterator end() { return iterator(this->n); }
};
typedef RangeTemplate< int > Range ;
typedef RangeTemplate< unsigned int > uRange ;
typedef RangeTemplate< long int > lRange ;
typedef RangeTemplate< unsigned long int > ulRange ;
typedef RangeTemplate< long long int > llRange ;
typedef RangeTemplate< unsigned long long int > ullRange ;
#endif /* RANGE_H */
