{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  numpy,
  scipy,
}:

buildPythonPackage (finalAttrs: {
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
