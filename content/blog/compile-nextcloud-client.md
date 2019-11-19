title: Compile Nextcloud client on OpenBSD 6.3
category: blog
tags: comp
date: 2018-06-06 16:23
modified: 2019-11-19 07:58:15

nextcloudclient is now available on OpenBSD ports tree \o/
[(discussion on miling list)](https://marc.info/?l=openbsd-ports&w=2&r=1&s=nextcloudclient&q=b)


Installing dependencies (other dependencies are dependencies of those packages):

    # pkg_add qtwebkit qtkeychain-qt5 cmake libinotify

Clone Nextcloud client repository:

    $ mkdir -p ~/src
    $ cd ~/src
    $ git clone https://github.com/nextcloud/client_theming.git nextcloud-client
    
Compiling:

    $ cd nextcloud-client
    $ git submodule update --init --recursive
    $ mkdir build
    $ cd build
    $ cmake -DOEM_THEME_DIR=/home/$USER/src/nextcloud-client/nextcloudtheme \
        -DCMAKE_PREFIX_PATH=/usr/local/lib/qt5/cmake \
        -DCMAKE_C_FLAGS="-I/usr/local/include -I/usr/local/include/inotify" \
        -DCMAKE_CXX_FLAGS="-I/usr/local/include -I/usr/local/include/inotify" \
        -DCMAKE_EXE_LINKER_FLAGS="-L/usr/local/lib -L/usr/local/lib/inotify -Wl,-rpath=/usr/local/lib/inotify -linotify" \
        -DHAVE_ICONV=1 -DHAVE_ICONV_H=1 \
        -DCMAKE_DISABLE_FIND_PACKAGE_KF5=TRUE \
        -DCMAKE_DISABLE_FIND_PACKAGE_Qt5LinguistTools=TRUE \
        /home/$USER/src/nextcloud-client/client
    $ make
    $ doas make install

everything should be fine! ;-)

## Running the client

Depending on the number of files you sync, you may need to increase the open files limit:

    $ ulimit -n 4096
    $ nextcloud
    
Increase the `ulimit` as your necessity.
