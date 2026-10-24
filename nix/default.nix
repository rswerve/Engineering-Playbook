# to install into the project profile that NIX_PROFILE names (see nix/update.sh)
# nix-env -p "$NIX_PROFILE" -f nix -i
#
# use
#
# https://lazamar.co.uk/nix-versions/
# to find rev for specific package version

let
  pkgs = import <nixpkgs> { };
  inherit (pkgs) buildEnv;
in
buildEnv {
  name = "eng-playbook-packages";
  paths = [

    (import
      (builtins.fetchGit {
        # Descriptive name to make the store path easier to identify
        name = "bash-5.1-p4";
        url = "https://github.com/NixOS/nixpkgs/";
        ref = "refs/heads/nixpkgs-unstable";
        rev = "253aecf69ed7595aaefabde779aa6449195bebb7";
      })
      { }).bash_5

    (import
      (builtins.fetchGit {
        # Descriptive name to make the store path easier to identify
        name = "nodejs-22.23.4";
        url = "https://github.com/NixOS/nixpkgs/";
        ref = "refs/heads/master";
        rev = "1a9d46887bff0b14383eaec8cd0fa87c7c4baae0";
      })
      { }).nodejs_22

    (import
      (builtins.fetchGit {
        # Descriptive name to make the store path easier to identify
        name = "circleci-cli-0.1.15663";
        url = "https://github.com/NixOS/nixpkgs/";
        ref = "refs/heads/nixpkgs-unstable";
        rev = "23cedc3088a628e1f5454cab6864f9b1a059e1ba";
      })
      { }).circleci-cli

    (import
      (builtins.fetchGit {
        # Descriptive name to make the store path easier to identify
        name = "pre-commit-4.7.0";
        url = "https://github.com/NixOS/nixpkgs/";
        ref = "refs/heads/master";
        rev = "1a9d46887bff0b14383eaec8cd0fa87c7c4baae0";
      })
      { }).pre-commit
  ];

  # the pre-commit hooks expects the binary to be `circleci`
  postBuild = ''
    ln -s $out/bin/circleci-cli $out/bin/circleci
  '';
}
