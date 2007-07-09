pydelicious
===========
Basicly, a Python library to access del.icio.us.
Includes shell utility to manage a local collection of bookmarks.

Based on work done by Frank Timmermann\ [#]_. See `license.txt`__. 

Overview
--------
Access to the del.icio.us web service API is implemented in `pydelicious.py`__.

`tools/dlcs.py`__ 
    an executable script that offers command-line access to your bookmark collection. 
`doc/`__
    Documentation generated from source.
`tests/`__
    Unittest-cases.
`var/`__
    Test data, etc.

.. __: ./license.txt
.. __: ./pydelicious.py
.. __: ./tools/dlcs.py
.. __: ./doc
.. __: ./tests
.. __: ./var

Documentation
-------------
For help and TODO's, progress reporting:

- `pydelicious.py`__
- `dlcs.py`__

.. __: ./doc/pydelicious.html
.. __: ./doc/dlcs.html

Other TODO's:
    
- Integrate tests/pydelicioustest.py, tests/pydelicious-test-utf-8.py    
- blackbox tests have encoding issues...


Configuration 
-------------

Resolution
~~~~~~~~~~~~~~~~
In order of preference:

 - '.dlcs-rc' in the current working directory
 - 'DLCS_CONFIG' environment variable
 - if those two don't exist: '~/.dlcs-rc'
 - finally, value passed with '-c' or '--config' overrides all

References
----------

.. [#] Google Code, ``pydelicious`` (http://code.google.com/p/pydelicious/).


