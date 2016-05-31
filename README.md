# Ocelot-mod

Ocelot-mod is a BitTorrent tracker written in C++, based on the Ocelot codebase. It supports requests over TCP and can only track IPv4 peers.

## Differences between Ocelot-mod and Ocelot

* Ocelot by default clears the peers table each time it is started. This is now optional.
* Many older trackers allowed a trailing / on the end of their announce URLs. This is now allowed in Ocelot-mod, allowing existing peers to be migrated seamlessly.
* All table names can now be specified at runtime using the config file. User and torrent ID's, and some other important columns can also be customised.
* A lightweight example schema, tidied up and including foreign keys, is included. This should be especially useful when using Ocelot-mod with a frontend other than gazelle.
* Ocelot currently writes out peers of deleted torrents which are inserted into the flush accumulator just before the torrent is purged. This has been mitigated using INSERT IGNORE combined with foreign key restraints.

## Ocelot Compile-time Dependencies

* [GCC/G++](http://gcc.gnu.org/) (4.7+ required; 4.8.1+ recommended)
* [Boost](http://www.boost.org/) (1.55.0+ required)
* [libev](http://software.schmorp.de/pkg/libev.html) (required)
* [MySQL++](http://tangentsoft.net/mysql++/) (3.2.0+ required)
* [TCMalloc](http://goog-perftools.sourceforge.net/doc/tcmalloc.html) (optional, but strongly recommended)

### Standalone Installation

* Create a database and import schema.sql

* Edit `ocelot.conf` to your liking.

* Build Ocelot:

        ./configure --with-mysql-lib=/usr/lib/x86_64-linux-gnu/ --with-ev-lib=/usr/lib/x86_64-linux-gnu/ --with-boost-libdir=/usr/lib/x86_64-linux-gnu
        make
        make install

## Running Ocelot

### Run-time options:

* `-c <path/to/ocelot.conf>` - Path to config file. If unspecified, the current working directory is used.
* `-v` - Print queue status every time a flush is initiated.

### Signals

* `SIGHUP` - Reload config
* `SIGUSR1` - Reload torrent list, user list and client whitelist
