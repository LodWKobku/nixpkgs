{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  hatchling,
  hatch-fancy-pypi-readme,

  # dependencies
  httpx,
  pydantic,
  typing-extensions,
  anyio,
  distro,
  sniffio,

  # optional-dependencies
  aiohttp,
  httpx-aiohttp,

  # tests
  versionCheckHook,
}:

buildPythonPackage (finalAttrs: {
    pname = "perplexityai";
    version = "0.36.0";
    pyproject = true;

    src = fetchFromGitHub {
        owner = "perplexityai";
        repo = "perplexity-py";
        tag = "v${finalAttrs.version}";
        hash = "sha256-3XReAbfJ1ysdqXfAHiuxgpVBZsJCIL+h56iB1eSzp54=";
    };

    build-system = [
        hatchling
        hatch-fancy-pypi-readme
    ];

    dependencies = [
        httpx
        pydantic
        typing-extensions
        anyio
        distro
        sniffio
    ];

    optional-dependencies = {
        aiohttp = [
            aiohttp
            httpx-aiohttp
        ];
    };
    nativeCheckInputs = [
        versionCheckHook
    ];
    versionCheckProgramArg = "version";
    pythonImportsCheck = [ "perplexity" ];
    
    meta = {
        description = "The official Python library for the perplexity API";
        homepage = "https://github.com/perplexityai/perplexity-py";
        changelog = "https://github.com/perplexityai/perplexity-py/releases/tag/${finalAttrs.src.tag}";
        license = lib.licenses.asl20;
        maintainers = with lib.maintainers; [
            LodWKobku
        ];
    };
})