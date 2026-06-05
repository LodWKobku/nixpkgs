{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  numpy,
  scipy,
  trec_eval,
}:

buildPythonPackage (finalAttrs: rec {
  pname = "pytrec-eval";
  version = "0.5";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "cvangysel";
    repo = "pytrec_eval";
    tag = finalAttrs.version;
    hash = "sha256-t76D3C5QMJgQMhAg8TGxdtjwaLQhlB8SufAdM3pAZg4=";
    fetchSubmodules = true;
  };

  build-system = [
    setuptools
  ];

  nativeBuildInputs = [ trec_eval ];

  CFLAGS = "-std=gnu89 -Wno-incompatible-pointer-types";

  patchPhase = ''
    mkdir -p trec_eval
    cp -r ${trec_eval.src}/* trec_eval/
    substituteInPlace setup.py \
      --replace "extra_compile_args=['-g', '-Wall', '-O3']" \
      "extra_compile_args=['-g', '-Wall', '-O3', '-Wno-incompatible-pointer-types']"
  '';

  dependencies = [
    numpy
    scipy
  ];

  pythonImportsCheck = [
    "pytrec_eval"
  ];

  meta = {
    description = "Pytrec_eval is an Information Retrieval evaluation tool for Python, based on the popular trec_eval";
    homepage = "https://github.com/cvangysel/pytrec_eval";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ LodWKobku ];
  };
})
