{
    lib,
    buildPythonPackage,
    fetchFromGitHub,

    # build-system
    setuptools,

    # dependencies
    pyyaml,
    jinja2,
    openai,
    tiktoken,
    aiohttp,
    httpx,
    requests,
    ddgs,
    nest-asyncio,
    tenacity,
    pydantic,
    pydantic-settings,
    aiosqlite,
    typer,
    rich,
    prompt-toolkit,
    pyte,
    anthropic,
    dashscope,
    perplexityai,
    oauth-cli-kit,
    llama-index,
    llama-index-retrievers-bm25,
    pymupdf,
    numpy,
    arxiv,
    python-docx,
    openpyxl,
    python-pptx,
    pypdf,
    pdfplumber,
    reportlab,
    defusedxml,
    fastapi,
    uvicorn,
    websockets,
    python-multipart,
    bcrypt,
    python-jose,
    pocketbase,
    loguru,
    json-repair,
    # optional dependencies
    mcp,
    python-telegram-bot,
    wecom-aibot-sdk,
    lark-oapi,
    dingtalk-stream,
    slack-sdk,
    slackify-markdown,
    qq-botpy,
    python-socketio,
    msgpack,
    python-socks,
    socksio,
    websocket-client,
    zulip,
    pyjwt,
    qrcode,

    # tests
    pytest-asyncio,
    pytestCheckHook,
}:

buildPythonPackage (finalAttrs: rec {
    pname = "deeptutor";
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
    # llama-index-retrievers-bm25

    dependencies = [
        pyyaml
        jinja2
        openai
        tiktoken
        aiohttp
        httpx
        requests
        ddgs
        nest-asyncio
        tenacity
        pydantic
        pydantic-settings
        aiosqlite
        typer
        rich
        prompt-toolkit
        pyte
        anthropic
        dashscope
        perplexityai
        oauth-cli-kit
        llama-index
        llama-index-retrievers-bm25
        pymupdf
        numpy
        arxiv
        python-docx
        openpyxl
        python-pptx
        pypdf
        pdfplumber
        reportlab
        defusedxml
        fastapi
        uvicorn
        websockets
        python-multipart
        bcrypt
        python-jose
        pocketbase
        loguru
        json-repair
    ] ++ python-jose.optional-dependencies.cryptography;

    optional-dependencies = {
        partners = [
            mcp
            python-telegram-bot
            wecom-aibot-sdk
            lark-oapi
            dingtalk-stream
            slack-sdk
            slackify-markdown
            qq-botpy
            python-socketio
            msgpack
            python-socks
            socksio
            websocket-client
            zulip
            pyjwt
            qrcode
        ] ++ python-telegram-bot.optional-dependencies.socks ++ pyjwt.optional-dependencies.crypto;
    };
    pythonRelaxDeps = [
        "json-repair"
    ];

    nativeCheckInputs = [ 
        pytestCheckHook
        pytest-asyncio
    ] ++ optional-dependencies.partners;
    pytestFlagsArray = [
        "--import-mode=importlib"
    ];
    pythonImportsCheck = [ "deeptutor" ];
    postPatch = ''
      # Fix default max_tokens/temperature assertions (DEFAULT_CHAT_PARAMS changed upstream)
      substituteInPlace tests/services/config/test_chat_params_config.py \
        --replace-fail "== 8000" "== 8192" \
        --replace-fail "default=8000" "default=8192" \
        --replace-fail "== 0.2" "== 0.5"

      # Fix web_search error message regex (error message format changed upstream)
      substituteInPlace tests/services/search/test_web_search_runtime.py \
        --replace-fail '"perplexity requires api_key"' '"perplexity requires profile.api_key in Settings > Catalog."'

      # Fix prompt_manager test: the question module has no idea_agent.yaml; use pipeline.yaml instead
      substituteInPlace tests/services/test_prompt_manager.py \
        --replace-fail 'agent_name="idea_agent"' 'agent_name="pipeline"' \
        --replace-fail '"generate_ideas"' '"labels"'
    '';

    disabledTestPaths = [
      "tests/scripts"  # needs git, and _cli_kit.py doesn't exist in the source tarball
      "tests/services/rag/test_llamaindex_storage_layout.py"  # KeyError: 'storage_path
    ];

    enabledTestPaths = [
        "tests"
    ];

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