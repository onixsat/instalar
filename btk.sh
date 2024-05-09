#!/bin/bash
thisFilePath="$( dirname "${BASH_SOURCE[0]}" )"
source "$thisFilePath/libs/pathUtils.sh"
srcLibFile "menuUtils.sh"
srcConfigFile "menus.sh"

TRUE=0
FALSE=1
NIL='nil'

ORIG_DIR="$(pwd)"
SCRIPT_DIR="$(getActiveScriptDir)"
BASHRC=~/.bashrc

function main() {
    keepGoing=$TRUE
    cd "$SCRIPT_DIR"
    init
    
    while keepGoing; do
        loadMenu "mainMenu" || l8r
    done
    
    cd "$ORIG_DIR"
    resetBashFunctions
    clear
}

function keepGoing() {
    return $keepGoing;
}

function init() {
    HEADER="$HEADER_MSG"
}

# Uma vez que este arquivo deve ser originado para definir variáveis env,
# Muitas funções também são definidas no escopo env; Daí este hack
# para remover todas as funções env e, em seguida, redefinir a partir do arquivo BASHRC
function resetBashFunctions() {
    echo "Removing all functions in current shell... Count:"
    declare -F |wc -l
    for line in $(declare -F | cut -d' ' -f3); do unset -f $line; done
    echo "Removed. Function Count:"
    declare -F |wc -l
    . $BASHRC
    echo "Reset BASHRC; Function Count:"
    declare -F |wc -l
}

main "$@"
