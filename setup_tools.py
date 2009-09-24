#!/usr/bin/env python
"""setup_tools - manages installation for pydelicious-tools, located in the 
tools/ directory.

(not to be confused with setuptools, which is the distutils extension on which
the installer is based).

This file is in the public domain.
"""
from setuptools import setup

#import sys
#sys.exit("Don't use this, installing tools is broken at the moment.")


# http://swik.net/Zope/Planet+Zope/How-to:+Install+Python+shell+scripts+with+Buildout/cfdy0
# http://www.bud.ca/blog/how-to-install-python-shell-scripts-with-buildout
# writes it is better to use buildout, and i'm not entirely satisfied with the
# current installer.

# FIXME: after editing needs to run twice because of broken header in egg.. clean up something.. ?

setup(
    name = 'pydelicious-tools',
    version = '0.2',
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
            'dlcs = pydelicious.tools.pkg_dlcs:main'
        ]
    }
)

