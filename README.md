# hi-im-kent dotfiles

My customization files

# Requirements

You need to install Nix (If you want to create the ISO file yourself)

Windows (WSL 2)
`sh <(curl -L https://nixos.org/nix/install) --no-daemon`

MacOS
`sh <(curl -L https://nixos.org/nix/install)`

Linux
`sudo sh <(curl -L https://nixos.org/nix/install) --daemon`

# Install (Linux only rn, don't know the commands of other systems)

Linux 

`cd ./Downloads`

`cat nixos-iso.tar.gz?? > nixos-iso.tar.gz`

# Create the ISO if you want to

`git clone https://github.com/hi-im-kent/dotfiles`

`cd ./dotfiles`

`nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=a.nix`
