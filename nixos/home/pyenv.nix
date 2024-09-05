{ pkgs, ... }:
{
  programs.pyenv = {
    enable = true;
    enableZshIntegration = true;
  };

  # Based on: https://semyonsinchenko.github.io/ssinchenko/post/using-pyenv-with-nixos/
  home.sessionVariables = {
    CPPFLAGS = "-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl.dev}/include";
    CXXFLAGS = "-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl.dev}/include";
    CFLAGS = "-I${pkgs.openssl.dev}/include";
    LDFLAGS = "-L${pkgs.zlib.out}/lib -L${pkgs.libffi.out}/lib -L${pkgs.readline.out}/lib -L${pkgs.bzip2.out}/lib -L${pkgs.openssl.out}/lib";
    CONFIGURE_OPTS = "-with-openssl=${pkgs.openssl.dev}";
  };
}
