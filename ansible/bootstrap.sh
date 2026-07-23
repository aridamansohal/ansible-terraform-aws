#!/usr/bin/env bash
set -euo pipefail

VENV_DIR="$HOME/venvs/ansible"
PYTHON_BIN="python3.12"

echo "======================================================"
echo "        Ansible Controller Bootstrap"
echo "======================================================"

# Check Python
if ! command -v ${PYTHON_BIN} >/dev/null 2>&1; then
    echo "ERROR: ${PYTHON_BIN} is not installed."
    echo "Install Python 3.12 first and rerun this script."
    exit 1
fi

# Check required files
for file in requirements.txt requirements.yml; do
    if [ ! -f "$file" ]; then
        echo "ERROR: Missing $file in $(pwd)"
        exit 1
    fi
done

# Create or reuse virtual environment
if [ ! -d "${VENV_DIR}" ]; then
    echo "Creating virtual environment..."
    ${PYTHON_BIN} -m venv "${VENV_DIR}"
else
    echo "Using existing virtual environment..."
fi

# Activate venv
source "${VENV_DIR}/bin/activate"

echo "Upgrading pip..."
pip install --upgrade pip

echo "Installing Python dependencies..."
pip install -r requirements.txt

echo "Installing Ansible collections..."
ansible-galaxy collection install -r requirements.yml

echo
echo "======================================================"
echo "Installation completed successfully!"
echo "======================================================"

echo
echo "Python Version:"
python --version

echo
echo "Ansible Version:"
ansible --version

echo
echo "Installed Collections:"
ansible-galaxy collection list
