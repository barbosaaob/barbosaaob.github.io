title: Nix package manager
tags: comp
category: blog
date: 2022-11-24
modified: 2022-11-24
status: draft

# intro

[Nix](https://nixos.org/nix/manual) is a powerful package manager for Linux and
other Unix systems that makes package management reliable and reproducible. It
uses [Nix language](https://nixos.org/guides/nix-language.html) to declare
packages and configurations to be built by Nix.

Nix uses a single directory to store packages and all other stuff related to
it. Packages in Nix are stored in directories such as

    /nix/store/jibjl4rxy9cnmwcmsglwfk6f2azh4gll-firefox-107.0/
    ├── bin
    │   └── firefox
    ├── lib
    │   ├── firefox
    │   │   └── ...
    │   └── mozilla
    │       └── ...
    └── share
        ├── applications
        │   └── firefox.desktop
        └── icons
            └── ...

where the hash `jibjl...` is a unique identifier for the package which takes
into account package build settings and all its dependencies. Notice the
directories `bin`, `lib`, and `share` which we usually in the root directory `/`
in Linux and BSD systems.

The way Nix manages packages allows you to have multiple versions of the same
software installed at the same time without any conflict once each package is
packaged with all its dependencies. Obviously, it increases storage, but is also
allows one to switch between packages or rollback in case you don't like an
upgrade with a simple command.

# install Nix

There are two ways to install Nix, single and multi-user. Nix recommends
multi-user installation and lists the pros and cons of this method.

My choice when I did install it on a Debian machine for the first time was the
single-user method because I was the only user on that machine and the
uninstall process is easy as running `rm -rf /nix`.

Detailed information about each method can be found on [Nix
manual](https://nixos.org/manual/nix/stable/installation/installing-binary.html).

Single-user installation:

    $ sh <(curl -L https://nixos.org/nix/install) --no-daemon

Multi-user installation:

    $ sh <(curl -L https://nixos.org/nix/install) --daemon

# using Nix

### search for a package

    $ nix-env -qaP firefox
    nixpkgs.firefox-esr          firefox-102.5.0esr
    nixpkgs.firefox-esr-wayland  firefox-102.5.0esr
    nixpkgs.firefox              firefox-107.0
    nixpkgs.firefox-wayland      firefox-107.0
    nixpkgs.firefox-esr-91       firefox-91.13.0esr

Nix allows you to can use regex

    $ nix-env -qaP 'firefox.*'

### install a package

    $ nix-env -iA nixpkgs.firefox
    installing 'firefox-107.0'
    ...

### "uninstall" a package

    $ nix-env -e firefox
    uninstalling 'firefox-107.0'

This only makes the package unavailable to the user. Please read Nix
quirks below. 

### upgrade all packages

    $ nix-channel --update
    $ nix-env -u

# Nix quirks

### garbage collection

Uninstalling a package in Nix does not delete it from your disk as you
could, for example, rollback the system to the previous state. As storage is
not always enough as we wish, we need to actually delete those unused packages
and Nix knows how to do it without breaking anything.

The Nix utility `nix-collect-garbage` deletes all packages that aren’t in use
by any user profile or by a currently running program. You can run the garbage
collector after every uninstall, but you will lose the great rollback
functionality of Nix.

### nix-shell

Nix also allows you to test a package in a temporary shell environment with
`nix-shell`:

    [adriano@laptop:~]$ nix-shell -p jupyter
    ...
    [nix-shell:~]$ jupyter-notebook

All packages downloaded for use in this temporary environment remain on
your disk after you finish the use and will only be deleted on the next garbage
collection unless you actually install it.

# acknowledgments

Thanks to @solene@bsd.network, @n0r@sueden.social, @thedaemon@socel.net and
@distrotube@fosstodon.org for the debate on Mastodon which made me write this
post.
