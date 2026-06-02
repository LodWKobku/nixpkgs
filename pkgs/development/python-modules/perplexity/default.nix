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
  nix-update-script,
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

  build-system = [
    hatch-fancy-pypi-readme
    hatchling
  ];

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

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "";
    homepage = "https://github.com/perplexityai/perplexity-py";
    changelog = "https://github.com/perplexityai/perplexity-py/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ LodWKobku ];
  };
})
