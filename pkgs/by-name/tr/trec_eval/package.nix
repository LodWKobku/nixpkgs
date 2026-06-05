{
    lib,
    stdenv,
    fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "trec_eval";
  version = "9.0.8";
  src = fetchFromGitHub {
    owner = "usnistgov";
    repo = "trec_eval";
    tag = "v${finalAttrs.version}";
    hash = "sha256-vAeI2uIrYTKTlFTAv4z5A391AUPaSTGJccLVcIGutiU=";
    fetchSubmodules = true;
  };

  meta = {
    description = "Evaluation software used in the Text Retrieval Conference ";
    homepage = "https://github.com/usnistgov/trec_eval/";
    changelog = "https://github.com/usnistgov/trec_eval/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.nistSoftware;
    mainProgram = "trec_eval";
  };
})