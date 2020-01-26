puppet-lint-empty_lines_around_body-check
=========================================

A puppet-lint plugin to check for empty lines around bodies of
* classes
* conditional blocks (if/elsif/else, unless, case, selectors, ...)

[Actually, the plugin cheats and just looks for emtpy lines after an opening curly brace and before a closing curly brace.]

## Installation

### From the command line

```shell
$ gem install puppet-lint-empty_lines_around_body-check
```

## Checks

#### What you have done

There is an empty line either after the opening curly brace that starts a block or before the closing curly brace that ends a block.

```puppet
if $foo == 'bar' {

  ## some stuff

}
```

```puppet
class foo::config {

  ## some stuff

}
```

```puppet
case $facts['os']['name'] {

  'Solaris': { include role::solaris }
  default:   { include role::generic }

}
```

#### What you should have done

The indentation suffices to signal the start end end of a block, so blocks shouldn't have leading or trailing empty lines.

```puppet
if $foo == 'bar' {
  ## some stuff
}
```

```puppet
class foo::config {
  ## some stuff
}
```

```puppet
case $facts['os']['name'] {
  'Solaris': { include role::solaris }
  default:   { include role::generic }
}
```

#### Disabling the check

To disable this check, you can add `--no-empty_lines_around_block-check' to your puppet-lint command line.

```
$ puppet-lint --no-empty_lines_around_block-check /path/to/file.pp
```

## Acknowledgments

This plugin for `puppet-lint` has been written owing to the very nice [tutorial for writing puppet-lint checks](http://puppet-lint.com/developer/tutorial/).
