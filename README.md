Base copied from:  https://discourse.nixos.org/t/flake-and-custom-package/33108

Tested on macos with M1, Most thingys work.

# Requirements
nix: https://nixos.org/download/

# Getting started

## Download the repo and practice stuff
```bash
git clone https://github.com/newaetech/chipwhisperer
cd chipwhisperer
git submodule update --init jupyter # grab Jupyter notebook tutorials
```

## Start nix-shell with environment

Experemential features of nix are required, add into `~/.config/nix/nix.conf`
```
experimental-features = nix-command flakes
```


Run nix and jupyter
```bashw
# In this folder
nix develop

# In the shell, in chipwhisperer -folder
cd jupyter
jupyter notebook
```

Follow instructions from jupyter. Kernel is quite slow to start, so be patient.

Note: Target compiling doens't work with this approach.
