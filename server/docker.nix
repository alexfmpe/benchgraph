{ nixpkgs ? import ../nixpkgs.nix {} }:

let
  p = nixpkgs;
  benchgraph = import ./default.nix { inherit nixpkgs; };
  tmpDir = p.writeTextFile {
    name = "tmpdir";
    destination = "/tmp/.touch";
    text = "";
  };
in

p.dockerTools.buildLayeredImage {
  name = "novadiscovery/benchgraph";
  tag = "latest";
  contents = tmpDir;

  config = {
    Cmd = [ "${benchgraph}/bin/benchgraph" "/benchs" ];
  };
}
