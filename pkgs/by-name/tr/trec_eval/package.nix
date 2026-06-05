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
  };

  buildPhase = ''
    cat > version.h <<EOF
#define VERSIONID "${finalAttrs.version}"
EOF
    make CFLAGS='-g -I. -Wall -std=gnu89 -Wno-incompatible-pointer-types -include version.h'
  '';

  installPhase = ''
    mkdir -p "$out/bin"
    cp trec_eval "$out/bin/"
  '';

  doCheck = false;

  meta = {
    description = "Evaluation software used in the Text Retrieval Conference";
    homepage = "https://github.com/usnistgov/trec_eval/";
    changelog = "https://github.com/usnistgov/trec_eval/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.nistSoftware;
    mainProgram = "trec_eval";
  };
})