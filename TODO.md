* implement -d, --depth command line option

* split and combine on dashes and underscores (by default, allow user-specified split/combine chars)
  - also recombine by just dropping the delimiter

* split and combine on variable length substrings specified by the user

* split and combine on camelCase or TitleCase, etc.

* include support for a configuration file, `pathgro.conf` perhaps?

* operate on GET query variables and/or values

* accept a command-line flag for each expansion type (and create useful groups of these)

* prepend period to everything for "hiddens"