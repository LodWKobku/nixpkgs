{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,

  # dependencies
  # CLI
  pyyaml,
  jinja2,
  openai,
  tiktoken,
  anthropic,
  dashscope,
  aiohttp,
  httpx,
  requests,
  nest-asyncio,
  tenacity,
  pydantic,
  pydantic-settings,
  aiosqlite,
  llama-index,
  pymupdf,
  numpy,
  arxiv,
  python-docx,
  openpyxl,
  python-pptx,
  pypdf,
  defusedxml,
  ddgs,
  typer,
  rich,
  prompt-toolkit,

  ## server
  fastapi,
  uvicorn,
  websockets,
  python-multipart,
  bcrypt,
  python-jose,
  loguru,
  json-repair,
  ## tutorbot
  croniter,
  chardet,
  mcp,
  readability-lxml,
  python-telegram-bot,
  slack-sdk,
  python-socketio,
  msgpack,
  python-socks,
  socksio,
  websocket-client,
  zulip,

  # tests
  versionCheckHook,
}:

buildPythonPackage (finalAttrs: {
    pname = "deaptutor";
    version = "1.4.2";
    pyproject = true;

    src = fetchFromGitHub {
        owner = "HKUDS";
        repo = "DeepTutor";
        tag = "v${finalAttrs.version}";
        hash = "sha256-7LwXsYAKTIj7jvuF5t0dzplVu8Ww+rh92cMJyFHHHrM=";
    };

    build-system = [ setuptools ];

    # TODO:
    # dingtalk-stream
    # slackify-markdown
    # qq-botpy
    # pocketbase
    # perplexityai
    # oauth-cli-kit
    # llama-index-retrievers-bm25

    dependencies = [
        # CLI
        pyyaml
        jinja2
        openai
        tiktoken
        anthropic
        dashscope
        aiohttp
        httpx
        requests
        nest-asyncio
        tenacity
        pydantic
        pydantic-settings
        aiosqlite
        llama-index
        pymupdf
        numpy
        arxiv
        python-docx
        openpyxl
        python-pptx
        pypdf
        defusedxml
        ddgs
        typer
        rich
        prompt-toolkit

        # Server
        fastapi
        uvicorn
        websockets
        python-multipart
        bcrypt
        python-jose
        loguru
        json-repair
        # Tutorbot
        croniter
        chardet
        mcp
        readability-lxml
        python-telegram-bot
        slack-sdk
        python-socketio
        msgpack
        python-socks
        socksio
        websocket-client
        zulip
    ];

    nativeCheckInputs = [
        versionCheckHook
    ];
    versionCheckProgramArg = "version";
    pythonImportsCheck = [ "deaptutor" ];

    meta = {
        description = "Agent-native, Open-sourced Personalized Tutoring";
        mainProgram = "deeptutor";
        homepage = "https://github.com/HKUDS/DeepTutor";
        changelog = "https://github.com/HKUDS/DeepTutor/releases/tag/${finalAttrs.src.tag}";
        license = lib.licenses.asl20;
        maintainers = with lib.maintainers; [
            LodWKobku
        ];
    };
})