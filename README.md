# [fn06.org](https://fn06.org)

Generates HTML files from markdown with pandoc.

# To build

## With [nix](https://nixos.org/)

To build in `/nix/store` with symlinked `result`:
```
$ nix build
```

Or to create HTML files from markdown files in the working repo:
```
$ nix develop -c make
```

## Generic

Install Pandoc and run `$ make`
