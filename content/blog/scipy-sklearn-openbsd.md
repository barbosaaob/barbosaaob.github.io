title: Installing scipy and sklearn on OpenBSD using pip
category: blog
tags: comp
date: 2019-11-19 07:59:10
modified: 2019-11-19 07:59:10

Before we begin, both are available from OpenBSD ports tree! But if you need to
compile them for any purpose, you can use the following.

scipy needs Fortran compiler and Lapack

    doas pkg_add g95 lapack
    ln -s /usr/local/bin/egfortran ~/bin/f95
    pip install --user scipy

sklearn needs to be built [from source without
OpenMP](https://github.com/scikit-learn/scikit-learn/issues/14332). [Download
from GitHub](https://github.com/scikit-learn/scikit-learn/releases).

    pip install --user Cython
    cd ~/.local/lib/python3.7/site-packages
    tar zxf ~/Downloads/scikit-learn-0.20.4.tar.gz
    cd scikit-learn-0.20.4
    export SKLEARN_NO_OPENMP=TRUE
    python setup.py build
    python setup.py install --prefix=~/.local
