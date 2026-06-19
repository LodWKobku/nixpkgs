{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # Build system
  hatch-fancy-pypi-readme,
  hatchling,

  # Dependencies
  anyio,
  distro,
  httpx,
  pydantic,
  sniffio,
  typing-extensions,

  # Optional dependencies
  aiohttp,
  httpx-aiohttp,

  # Native check inputs
  dirty-equals,
  respx,
  time-machine,
  pytestCheckHook,
  pytest-asyncio
}:

buildPythonPackage (finalAttrs: {
  pname = "perplexityai";
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
    # Remove version requirement of hatchling and fix package tests
    substituteInPlace pyproject.toml \
      --replace-fail 'hatchling==1.26.3' 'hatchling' \
      --replace-fail "-n auto" ""
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

  # Tests
  pythonImportsCheck = [
    "perplexity"
  ];

  nativeCheckInputs = [
    dirty-equals
    pytestCheckHook
    pytest-asyncio
    respx
    time-machine
  ];
  enabledTestPaths = [
    "tests/"
  ];

  meta = {
    description = "The official Python library for the perplexity API";
    homepage = "https://github.com/perplexityai/perplexity-py";
    changelog = "https://github.com/perplexityai/perplexity-py/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ LodWKobku ];
  };
})
