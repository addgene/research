#! /bin/bash

ve_name="openbio"

export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export WORKON_HOME=$HOME/.virtualenvs
source virtualenvwrapper.sh

deactivate||echo "Not in a virtualenv"

if [ "$1" == "nuke" ]; then
    rmvirtualenv $ve_name
fi

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $script_dir

workon $ve_name

if [ $? -ne 0 ]; then
    mkvirtualenv $ve_name -p python3
fi

workon $ve_name
pip install -r ../requirements.txt

echo "source virtualenvwrapper.sh" >> $HOME/.bash_profile

