#!/usr/bin/env bash
set -euo pipefail

HERE="$(realpath "$(dirname "$0")")"
VENV="${HERE}/ve"

if [[ ! -e "${VENV}/bin/activate" ]]; then
  virtualenv -p python2 "${VENV}"
  "${VENV}/bin/pip" install -e "${HERE}"
fi

source "${HERE}/ve/bin/activate"

JENKINS_URL=
output_dir="${HERE}/output"
export JJW_USERNAME=
export JJW_PASSWORD=
jjwrecker -s "${JENKINS_URL}" -o "${output_dir}" "$@"
