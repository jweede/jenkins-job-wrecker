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
source <(python3 - <<PYTHON
import os
import yaml

with open(os.path.expanduser("~/.jenks")) as fp:
  jenks = yaml.safe_load(fp)

print("export JJW_USERNAME=" + jenks["main"]["username"])
print("export JJW_PASSWORD=" + jenks["main"]["password"])
PYTHON
)
jjwrecker -s "${JENKINS_URL}" -o "${output_dir}" "$@"
# rsync -auv --delete-before ./output/ ../platform/jenkins/jjb-non-phi/
