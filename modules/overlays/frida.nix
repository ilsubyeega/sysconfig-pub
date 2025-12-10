final: prev:
(
  let

    frida-python =
      pkg:
      (pkg.overrideDerivation (previous: {
        src = (
          prev.fetchPypi {
            version = "17.2.15";
            inherit (previous) pname wheel;
            hash = "sha256-3d1a5b2c7f0e4c896b9d5c8e1f3b2a4c5e6f7a8b9c0d1e2f3g4h5i6j7k8l9m0n=";
            platform = "manylinux1_x86_64";
            abi = "abi3";
            python = "cp37";
            dist = "cp37";
          }
        );
      }));

  in
  {

    final.python313Packages.frida-python = frida-python prev.python313Packages.frida-python;
    final.python312Packages.frida-python = frida-python prev.python312Packages.frida-python;

    frida-tools = (
      prev.frida-tools.overrideDerivation (previous: rec {
        version = "14.4.5";
        src = prev.fetchPypi {
          pname = previous.pname;
          inherit version;
          hash = "sha256-sId91KB2qLasJHsfrS6Nfqctn0kCPS6ieNwtfheai8M=";
        };
      })
    );

  }
)
