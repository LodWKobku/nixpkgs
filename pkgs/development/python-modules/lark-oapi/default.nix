{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  requests,
  requests-toolbelt,
  pycryptodome,
  websockets,
  httpx,
  aiohttp,
  fastapi,
  uvicorn,
  flask,
  pytest,
  pytest-asyncio,

  nix-update-script,
  pytestCheckHook,
}:

buildPythonPackage (finalAttrs: rec {
  pname = "lark-oapi";
  version = "1.6.8";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "larksuite";
    repo = "oapi-sdk-python";
    tag = "v${finalAttrs.version}";
    hash = "sha256-dFfg24TyCaGX+nu/HuD+UjHibdPMccn/X4V6SVdvO60=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    requests
    requests-toolbelt
    pycryptodome
    websockets
    httpx
  ];

  optional-dependencies = {
    aiohttp = [
      aiohttp
    ];
    fastapi = [
      fastapi
      uvicorn
    ];
    flask = [
      flask
    ];
    test = [
      pytest
      pytest-asyncio
    ];
  };

  pythonRelaxDeps = [
    "websockets"
  ];

  nativeCheckInputs = [ pytestCheckHook ] ++ optional-dependencies.test;
  pythonImportsCheck = [
    "lark_oapi"
  ];
  enabledTestPaths = [
    "lark_oapi/channel/tests"
  ];
  disabledTestPaths = [
    "lark_oapi/channel/tests/test_client_lifecycle.py" # Inconsistent test
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Larksuite development interface SDK";
    homepage = "https://github.com/larksuite/oapi-sdk-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ LodWKobku ];
  };
})
