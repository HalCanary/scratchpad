#!/usr/bin/env python

# zipme.py - Copyright 2008 Hal Canary
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

# To use me:
#   >>> from zipme import zipme
#   >>> zipme('directoryname')

import zipfile
import os
import os.path
def zipdir(z,x):
    if os.path.isfile(x):
        z.write(x)
        print 'wrote %s' % x
    elif os.path.isdir(x):
        for y in os.listdir(x):
            zipdir(z,x + os.sep + y)
    else:
        print 'ERROR: %s' % x

def zipme(d):
    z = zipfile.ZipFile(d+'.zip','w',zipfile.ZIP_DEFLATED)
    zipdir(z,d)
    z.close()

if __name__ == "__main__":
    zipme('Randoms')
