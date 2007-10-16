pydelicious
===========
Basicly, a Python library to access del.icio.us.
Includes shell utility to manage a local collection of bookmarks.

Based on work done by Frank Timmermann\ [#]_. See `license.txt`__.

Installation::

    % python setup.py install

Overview
--------
Access to the del.icio.us web service API is implemented in `pydelicious.py`__.

`doc/ <./doc/>`__
    Documentation generated from source. Generate with ``make doc``
`tests/ <./tests>`_
    Unittests, run with ``make test``.
`tools/dlcs.py <./tools/dlcs.py>`_
    an executable script that offers command-line access to your bookmark collection by caching the posts and tags XML files locally.
`var/ <./var>`_
    Test data, etc.

.. __: ./license.txt
.. __: ./pydelicious.py

Documentation
-------------
For help and TODO's, progress reports:

- `pydelicious.py`__
- `dlcs.py`__

.. __: ./doc/pydelicious.html
.. __: ./doc/dlcs.html

Other TODO's:

- tests have encoding issues...
- do blackbox testing
- create a setup entry for dlcs? other module?

References
----------

.. [#] Google Code, ``pydelicious`` (http://code.google.com/p/pydelicious/).
