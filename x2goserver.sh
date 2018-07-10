#!/usr/bin/env bash

sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get autoremove

sudo apt-get install python-software-properties
sudo apt-get install software-properties-common

sudo apt-get install xubuntu-desktop
sudo add-apt-repository ppa:x2go/stable
sudo apt-get update
sudo apt-get install x2goserver x2goserver-xsession
