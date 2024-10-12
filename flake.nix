{
description = "ChipWhisperer";
inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
#inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

outputs = { self, nixpkgs}:

#flake-utils.lib.eachSystem [ "aarch64-darwin" ] (system:
let
    supportedSystems = [ "aarch64-darwin" "avr-none" ];
    pkgs = import nixpkgs { system = "aarch64-darwin"; };
    chipwhisperer = pkgs.python3Packages.buildPythonPackage rec {
      pname = "chipwhisperer";
      version = "5.7.0";
      src = pkgs.fetchPypi  {
        inherit pname;
        inherit version;
        sha256 = "sha256-xTRUkdo09xKIEGITmEEHSVBd7cqrtD72lR/kklSt7Z8=";
      };
      buildInputs = with pkgs; [
        python310Packages.configobj
        python310Packages.tqdm
        python310Packages.numpy
        python310Packages.fastdtw
        python310Packages.pyserial
        python310Packages.libusb1
        python310Packages.ecpy
        python310Packages.cython
      ];
    };
    avrCrossPkgs = import nixpkgs {
        crossSystem = {
            config = "avr";
        };
        localSystem = "aarch64-darwin";
    };


  myShell = avrCrossPkgs.mkShell rec {
    name = "ChipWhisperer";


    nativeBuildInputs = with pkgs; [
      bash
      lcov
      pkg-config
      libffi
      gdbm
      lzma
      ncurses5
      readline
      sqlite
      openssl
      tk
      libuuid
      zlib
      zlib-ng
      curl
      libusb1
      gnumake
      avrCrossPkgs.avrlibc
      git
        jupyter
        python310
        python310Packages.configobj
        python310Packages.pip
        python310Packages.bokeh
        python310Packages.cycler
        #python310Packages.datashader
        python310Packages.notebook
        python310Packages.jupyter-client
        python310Packages.jupyter-core
        #python310Packages.nbparameterise
        python310Packages.pandas
        python310Packages.holoviews
        python310Packages.matplotlib
        python310Packages.pyyaml
        python310Packages.tqdm
        python310Packages.pycryptodome
        python310Packages.terminaltables
        #python310Packages.phoenixAES
        python310Packages.ipywidgets
        python310Packages.nbconvert
        python310Packages.numpy
      python310Packages.fastdtw
      python310Packages.pyserial
      python310Packages.libusb1
      python310Packages.ecpy
      python310Packages.cython
      libusb1
      chipwhisperer
    ];
  };

in {
  devShell."aarch64-darwin" = myShell;
};

#);
}
