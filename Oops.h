// Oops Exception
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
#ifndef OOPS_H
#define OOPS_H
#include <exception>
/**
   The Oops class can represent any unexpected state. */
class Oops : public std::exception {
  const char * m_description;
public:
  Oops(const char * s = NULL) : m_description(s) { }
  virtual const char * what() const throw() {
    return m_description ? m_description : "";
  }
};
#endif /* OOPS_H */
