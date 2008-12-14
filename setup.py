#!/usr/bin/env python
# 
# This file is in the public domain.
import sys
from setuptools import setup, Command
import src


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
    version = src.__version__,
    license = 'BSD',
    description = src.__description__,
    long_description = src.__long_description__,

    author = src.__author__,
    author_email = src.__author_email__,
    url = src.__url__,

    install_requires = requires,

    packages = ['pydelicious'],
    package_dir = { 'pydelicious': 'src/' },

    cmdclass = {
        'test': Test,
    },
)
