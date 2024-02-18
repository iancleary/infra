{
  description = "A Nix-flake-based Python development environment";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Simply the greatest package repository on the planet
    nixpkgs.url = "github:NixOS/nixpkgs";
    # A set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };

        ansible = pkgs.ansible_2_14;

         # task runner
        just = pkgs.just;
        # Run python packages in a isolated environment
        pre-commit = pkgs.pre-commit;

        nano = pkgs.nano;
        vim = pkgs.vim;

        ssh = pkgs.openssh;

        git = pkgs.git;

        graphite = pkgs.graphite-cli;

        repoTools = [ just pre-commit nano ssh git graphite vim];
      in {
        devShells = {
          default = pkgs.mkShell {
            # Packages included in the environment
            buildInputs = [ ansible ] ++ repoTools;

            # # Run when the shell is started up
            shellHook = ''
              printf "\n\nRepo Tools:\n" && which ansible && which just && which pre-commit && pre-commit install && printf "\n\n" && export GIT_EDITOR=nano;
            '';
          };
        };
      });
}
