#!/bin/bash
set -e

# Install ansible on debian or redhat based systems

if [[ $(which yum) ]]; then
    echo "System is RHEL, using yum to install pip3"
    sudo yum check-update

    echo "Installing ssh & python3"
    yum install -y sshpass
    yum install -y python3

    echo "Installing pip"
    yum install -y python3-pip

elif [[ $(which apt) ]]; then
    echo "System is Debian, using apt for installing pip3"
    echo "updating apt cache"
    sudo apt update

    echo "Installing latest python version.."
    echo ""
    sudo apt install -y -qq python3
    sudo apt install -y -qq sshpass
    echo "Installing pip3"
    echo ""
    sudo apt install -y -qq python3-pip

else
    echo "Script works on debain or RedHat based systems!"
    echo "Exit!"
    exit 0
fi

if [[ $# -eq 0 ]]; then
    echo "No version passed, Installing latest version."
    echo "Installing ansible for user"
    python3 -m pip install --user ansible

elif [[ $# -eq 1 ]]; then
    echo "Version passed. Installing ansible==$1"
    echo "Installing ansible for user"

    # Check if version is valid
    if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Version is valid"
    else
        echo "Version is not valid! Exiting!"
        exit 1
    fi

    # Check if version exists on pypi
    if python3 -m pip install --user ansible=="$1" --exists-action w; then
        echo "Version exists on pypi"
    else
        echo "Version does not exist on pypi!"
        echo "Check for available versions on pypi: https://pypi.org/project/ansible/#history"
        echo "or"
        echo "https://pypi.org/pypi/ansible/json"
        echo "Exiting!"
        exit 1
    fi
    python3 -m pip install --user ansible=="$1"
fi

echo "Install ansible-lint for user"
python3 -m pip install --user ansible-lint

echo "Install yamllint for user"
python3 -m pip install --user yamllint

if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
    echo "On WSL | Exporting ~/.local/bin"
    export PATH=$PATH:~/.local/bin
fi

#Checking version of tools
echo ""
pythonver="$(python3 -V 2>&1)"
pipver="$(pip3 -V 2>&1)"
ansiblever="$(ansible --version 2>&1)"
ansiblelint="$(ansible-lint --version 2>&1)"
yamllint="$(yamllint --version 2>&1)"

echo "Ansible sanity test.."
echo ""
ansible localhost -m ping
echo ""
echo "Versions:"
echo ""
echo "Python: $pythonver"
echo "Pip: $pipver"
echo "Ansible: $ansiblever"
echo "ansible-lint: $ansiblelint"
echo "yamllint: $yamllint"
echo ""

echo "End!"
