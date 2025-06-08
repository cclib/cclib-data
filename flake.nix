{
  description = "Parsers and algorithms for computational chemistry logfiles (regression data)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      /*
        Change this value ({major}.{min}) to
        update the Python virtual-environment
        version. When you do this, make sure
        to delete the `.venv` directory to
        have the hook rebuild it for the new
        version, since it won't overwrite an
        existing one. After this, reload the
        development shell to rebuild it.
        You'll see a warning asking you to
        do this when version mismatches are
        present. For safety, removal should
        be a manual step, even if trivial.
      */
      version = "3.13";
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default =
          let
            concatMajorMinor =
              v:
              pkgs.lib.pipe v [
                pkgs.lib.versions.splitVersion
                (pkgs.lib.sublist 0 2)
                pkgs.lib.concatStrings
              ];
            python = pkgs."python${concatMajorMinor version}";
          in
          pkgs.mkShellNoCC {
            venvDir = ".venv";

            postShellHook = ''
                      venvVersionWarn() {
                local venvVersion
                venvVersion="$("$venvDir/bin/python" -c 'import platform; print(platform.python_version())')"

                [[ "$venvVersion" == "${python.version}" ]] && return

                cat <<EOF
              Warning: Python version mismatch: [$venvVersion (venv)] != [${python.version}]
                       Delete '$venvDir' and reload to rebuild for version ${python.version}
              EOF
              }

              venvVersionWarn
            '';

            packages = [
              python.pkgs.pip
              python.pkgs.ruamel-yaml
              python.pkgs.venvShellHook
            ];
          };
      }
    );
}
