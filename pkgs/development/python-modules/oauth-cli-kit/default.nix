{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # Build system
  hatch-vcs,
  hatchling,

  # Dependencies
  httpx,
  platformdirs,

  # Tests
  pytest,
  pytestCheckHook,
}:

buildPythonPackage (finalAttrs: {
  pname = "oauth-cli-kit";
  version = "0.1.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pinhua33";
    repo = "oauth-cli-kit";
    tag = "v${finalAttrs.version}";
    hash = "sha256-dJSiR/1fKvYbB8r7pU58vnDeREG/k1YmnhC5qEFtbo4=";
  };

  build-system = [
    hatch-vcs
    hatchling
  ];

  dependencies = [
    httpx
    platformdirs
  ];

  optional-dependencies = {
    dev = [
      pytest
    ];
  };

  # Tests
  nativeCheckInputs = [ pytestCheckHook ];
  enabledTestPaths = [
    "tests/"
  ];
  pythonImportsCheck = [
    "oauth_cli_kit"
  ];

  meta = {
    description = "A small, reusable OAuth 2.0 + PKCE helper focused on CLI apps";
    homepage = "https://github.com/pinhua33/oauth-cli-kit";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ LodWKobku ];
  };
})
