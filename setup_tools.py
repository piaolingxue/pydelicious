#!/usr/bin/env python
"""setup_tools - manages installation for pydelicious-tools, located in the 
tools/ directory.

(not to be confused with setuptools, which is the distutils extension on which
the installer is based).

This file is in the public domain.
"""
from setuptools import setup

import sys
sys.exit("Don't use this, installing tools is broken at the moment.")


# http://www.bud.ca/blog/how-to-install-python-shell-scripts-with-buildout
# writes it is better to use buildout, but this works for me (@ Debian
# GNU/Linux)

# XXX: this has no uninstall, and using a package gets slightly more complicated
# than a module

setup(
    name = 'Pydelicious Tools',
    version = '0.1',
    license = 'BSD',
    description = '',
    long_description = """
    """,

    author = 'B. van Berkum',
    author_email = 'berend+pydelicious@dotmpe.com',
    url = 'http://code.google.com/p/pydelicious/',

    install_requires = ['pydelicious >=0.5.1'],

    packages = ['pydelicious.tools'],
    package_dir = {'pydelicious.tools': 'tools'},

    entry_points = {
        'console_scripts': [
            'dlcs = pydelicious.tools.dlcs:main'
        ]
    }
)

