{
  llama-cpp,
  runCommand,
  fetchurl,
  lib,
}:
{
  extraArgs ? [],
  prompt,
  model ? fetchurl {
    url = "https://huggingface.co/mradermacher/hpc-coder-v2-1.3b-GGUF/resolve/main/hpc-coder-v2-1.3b.Q4_K_M.gguf";
    hash = "sha256-K5h8zv4pCZw6j6LMrQxrOSn87kJx9Effinu1TsKWnzQ=";
  },
  seed ? 0,
}:
runCommand "ai-generated-source-code" { } ''
  echo ${model}
  set -x
  ${llama-cpp}/bin/llama-cli ${lib.escapeShellArgs extraArgs} --seed "${toString seed}" --model ${model} --prompt ${lib.escapeShellArg prompt} | sed 's/ \[end of text\]//g' > $out
''
