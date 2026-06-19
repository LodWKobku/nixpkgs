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

    # tests
    versionCheckHook,
}:

buildPythonPackage (finalAttrs: {
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
    ];

    pythonRelaxDeps = [
        "json-repair"
    ];

    nativeCheckInputs = [
        versionCheckHook
    ];
    versionCheckProgramArg = "version";
    pythonImportsCheck = [ "deeptutor" ];

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