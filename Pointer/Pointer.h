// Pointer Template
// Copyright 2013 Hal Canary
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
#ifndef POINTER_H
#define POINTER_H
#include <cstdlib> // std::free(void *)

/**
   A wrapper for the C free function that makes it type-correct. */
template< typename T >
inline void free(T * t_ptr) {
  std::free(static_cast< void * >(t_ptr) );
}

/**
   A wrapper for C pointers that makes them smart pointers. */
template< typename T >
class Pointer {
private:
  T * m_ptr;
  void (*m_free)(T *);
  Pointer(const Pointer & p) { /* disallowed */}
public:
  Pointer ( T * ptr, void (*freefn)( T *))
    : m_ptr(ptr), m_free(freefn) { }
  /** Default to using std::free(void *) */
  Pointer ( T * ptr )
    : m_ptr(ptr), m_free(&(free< T >)) { }
  ~Pointer () {
    if (m_ptr)
      m_free(m_ptr);
  }
  Pointer & operator=(T * ptr) {
    if (m_ptr)
      m_free(m_ptr);
    m_ptr = ptr;
    return *this;
  }
  operator T * () { return m_ptr; }
  operator T * () const { return m_ptr; }
  bool operator!() const { return (! m_ptr); }
  T ** operator&() { return &m_ptr; }
  T ** operator&() const { return &m_ptr; }
  T * operator->() { return m_ptr; }
  T * operator->() const { return m_ptr; }
};

#endif /* POINTER_H */
