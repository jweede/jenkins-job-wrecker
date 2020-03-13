#!/usr/bin/env bash
set -euo pipefail

HERE="$(realpath "$(dirname "$0")")"
VENV="${HERE}/venv"

if [[ ! -e "${VENV}/bin/activate" ]]; then
  virtualenv -p python3 "${VENV}"
  "${VENV}/bin/pip" install -e "${HERE}"
fi

source "${VENV}/bin/activate"

JENKINS_URL=https://jenkins.kyruus.com/
output_dir="${HERE}/output"
export JJW_USERNAME=
export JJW_PASSWORD=
jjwrecker -s "${JENKINS_URL}" -o "${output_dir}" "$@"
