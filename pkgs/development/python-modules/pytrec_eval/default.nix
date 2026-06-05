{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchurl,
  setuptools,
  numpy,
  scipy,
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

  trecEvalSrc = fetchurl {
    url = "https://github.com/usnistgov/trec_eval/archive/v9.0.8.tar.gz";
    sha256 = "18bbarix8jwq71gw3p1nbk1i8n54hjap94zn5phl5j1y21rlm6f3";
  };

  build-system = [
    setuptools
  ];

  CFLAGS = "-std=gnu89 -Wno-incompatible-pointer-types";

  patchPhase = ''
    mkdir -p trec_eval
    tar xzf ${trecEvalSrc} --strip-components=1 -C trec_eval
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
