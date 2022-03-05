#!/bin/bash
if [[ `which yum` ]]; then
   IS_RHEL=1
   echo "System is RHEL, using yum to install pip3"
   sudo yum check-update

   echo "Installing ssh & python3"
   yum install -y sshpass
   yum install -y python3

   echo "Installinig pip"
   yum install -y python3-pip

elif [[ `which apt` ]]; then
   IS_UBUNTU=1
   echo "System is Debian, using apt for installing pip3"
   echo "updating apt cache"
   sudo apt update
   
   echo "Updating apt packages"
   sudo apt -y upgrade
   echo "Installing latest python version.."
   echo ""
   sudo apt install python3
   sudo apt install sshpass
   echo "Installing pip3"
   echo ""
   sudo apt install python3-pip

else
   IS_UNKNOWN=1
   echo "Script works on debain or RedHat based systems!"
   echo "Exit!"
   exit 0
fi

echo "Installing ansible for user"
python -m pip install --user ansible

echo ""
echo "Installing ansible-lint"
python3 -m pip install --user ansible-lint

echo "Checking versions of installed software:"
echo ""
pythonver="$(python -V 2>&1)"
pipver="$(pip3 -V 2>&1)"
ansiblever="$(ansible --version 2>&1)"
ansiblelint="$(ansible-lint --version 2>&1)"

echo "Ansible sanity test.."
echo ""
ansible localhost -m ping
echo ""

echo "Python: $pythonver"
echo "Pip: $pipver"
echo "Ansible: $ansiblever"
echo "Ansible-lint: $ansiblelint"
echo "End!"
