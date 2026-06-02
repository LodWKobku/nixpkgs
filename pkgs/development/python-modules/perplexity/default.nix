{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatch-fancy-pypi-readme,
  hatchling,
  anyio,
  distro,
  httpx,
  pydantic,
  sniffio,
  typing-extensions,
  aiohttp,
  httpx-aiohttp,
}:

buildPythonPackage (finalAttrs: {
  pname = "perplexity";
  version = "0.36.0";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "perplexityai";
    repo = "perplexity-py";
    tag = "v${finalAttrs.version}";
    hash = "sha256-3XReAbfJ1ysdqXfAHiuxgpVBZsJCIL+h56iB1eSzp54=";
  };

  postPatch = ''
    # Remove version requirement of hatchling
    substituteInPlace pyproject.toml \
      --replace-fail 'hatchling==1.26.3' 'hatchling'
  '';

  build-system = [
    hatch-fancy-pypi-readme
    hatchling
  ];

  pythonRelaxDeps = true;

  dependencies = [
    anyio
    distro
    httpx
    pydantic
    sniffio
    typing-extensions
  ];

  optional-dependencies = {
    aiohttp = [
      aiohttp
      httpx-aiohttp
    ];
  };

  pythonImportsCheck = [
    "perplexity"
  ];

  meta = {
    description = "";
    homepage = "https://github.com/perplexityai/perplexity-py";
    changelog = "https://github.com/perplexityai/perplexity-py/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ LodWKobku ];
  };
})
