#!/usr/bin/env bash

read -r -d '' ENV_CONFIG << EOM
  Main Menu
  - Install
EOM
describe "Testing"
createMenu "menuInstall" "$ENV_CONFIG"
addMenuItem "menuInstall" "Centos 8 Cpanel"  install1
addMenuItem "menuInstall" "Go back" loadMenu "mainMenu"
function install1() {
	echo "Update!"
	reload "return" "menuInstall"
	pause
}




