# <img height="50%" width="50%" src="https://raw.githubusercontent.com/decal/pathgro/master/assets/pathgro-logo.png"/>

## Introduction

`pathgro` freely commingles pathname parts into new omnifarious string mappings.
It is designed to maximize attack surface coverage when testing software 
components that take pathnames as input--when "dirbusting", for example.
It is a set of GNU guile modules with a command-line interface.

## Examples

General overview of the functionality:

<img height="65%" width="65%" src="https://raw.githubusercontent.com/decal/pathgro/assets/demo.gif"/>

## Dependencies

* **GNU Guile 2.x**


* **NOTE:** you must make sure that you have both `guile` and `guild` executables installed.\
Some distributions (e.g. *Debian*) provide `guild` separately from `guile`, so simply\
installing a package called `guile` may not be sufficient.\
(*Debian* provides `guild` in a package called `guile-2.x-dev`)

## Installation

``` shell
# install the required guile binaries
$ sudo apt install guile guile-2.0-dev

# or alternatively..
$ sudo apt install linuxbrew-wrapper && brew install guile 
# don't forget to add ~/.linuxbrew/Cellar/guile/2.x.x/bin to PATH

# clone the reposityory:
$ git clone https://github.com/decal/pathgro

# change working directory to pathgro:
$ cd pathgro

# compile the source using the Makefile:
$ make

# install pathgro using the Makefile:
# note: it might be necessary to run this as root:
$ sudo make install
```

## Usage

<img height="50%" width="50%" src="https://raw.githubusercontent.com/decal/pathgro/assets/pathgro-command-line-usage.png" />

## License

`pathgro` is licensed under the GNU Lesser General Public License v3.0. [See LICENSE for more information](https://github.com/decal/pathgro/blob/master/LICENSE).
