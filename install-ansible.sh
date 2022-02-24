#! /bin/bash

echo "Update apt cache"

sudo apt update

echo "Updating apt packages"

sudo apt -y upgrade

echo "Install latest python version.."

sudo apt install python
pythonver="$(python -V 2>&1)"

echo "Install pip3"

sudo apt install python3-pip

pipver="$(pip3 -V 2>&1)"

echo "Install ansible for user"

python -m pip install --user ansible

ansiblever="$(ansible --version 2>&1)"

python -m pip install --user paramiko

echo "Check if ansible installed correctly"
echo ""
ansible localhost -m ping
echo ""
echo "Python: $pythonver"
echo "Pip: $pipver"
echo "Ansible: $ansiblever"
echo ""
echo "End!"
