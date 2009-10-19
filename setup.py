#!/usr/bin/env python
# 
# This file is in the public domain.
import sys
from setuptools import setup, Command
import pydelicious


class Test(Command):
    """Distutils Command to run API tests"""

    description = 'Run pydelicious API tests.'
    user_options = []

    def initialize_options(self): pass
    def finalize_options(self): pass

    def run(self):
        from tests import main
        main.test_api()


requires = ['feedparser']
if sys.version[0] == 2 and sys.version[1] <= 4:
    requires += [ 'elementtree >= 1.2' ]

elif sys.version[0] == 2 and sys.version[1] >= 5:
    # integrated into the standard library as xml.etree.*
    pass 

# TODO: need to see this work...
dependency_links = [
    "http://feedparser.org/feedparser.py#egg=feedparser-latest"
]


setup(
    name = 'pydelicious',
    version = pydelicious.__version__,
    license = 'BSD',
    description = pydelicious.__description__,
    long_description = pydelicious.__long_description__,

    author = pydelicious.__author__,
    author_email = pydelicious.__author_email__,
    url = pydelicious.__url__,

    install_requires = requires,

    packages = ['pydelicious'],
    package_dir = { 'pydelicious': 'pydelicious' },

    cmdclass = {
        'test': Test,
    },
)
