# !/bin/bash
# 

#-------------------------------------------------------------------------------------------------------
#--- FUNCTIONS


#-------------------------------------------------------------------------------------------------------
#--- CHECK FOR ELEVATED PRIVILEGES
if [ "$EUID" -ne 0 ]; then
  # echo -e "\nPlease run as this script as root\n"
  printf "\nPlease run as this script as root\n"
  exit 0;
fi

#--- INSTALLATION CONFIRMATION
echo -e "\nThis script is specifically for installing BigBlueButton on Ubuntu Server 16.04\n"
read -p "Do you wish to continue (y/n) : " RESPONSE
#RESPONSE='y'

if [ "$RESPONSE" == "y" ] || [ "$RESPONSE" == "Y" ]; then
  echo -e "\nRunning script..."
else
  echo -e "\nExiting.\n"
  printf "\nResponse: %s" $RESPONSE
  printf "\nExiting.\n"
  exit 0;
fi


# # First, check that the locale of the server is en_US.UTF-8.
# $ cat /etc/default/locale
# LANG="en_US.UTF-8"

# # If locale is not to as above then install and set:
# $ sudo apt-get install language-pack-en
# $ sudo update-locale LANG=en_US.UTF-8

# # Log out and back in
# # Check locale:
# $ cat /etc/default/locale
# LANG="en_US.UTF-8"

# # Note: If you see an additional line LC_ALL=en_US.UTF-8 :
# # then remove the entry for LC_ALL from /etc/default/locale and logout and then log back in once more.

# Next, do:
# $ sudo systemctl show-environment
# # ... and ensure you see LANG=en_US.UTF-8 in the output.

# # If you don’t see this, do:
# $ sudo systemctl set-environment LANG=en_US.UTF-8
# $ ... and run the above sudo systemctl show-environment again and confirm you see LANG=en_US.UTF-8 in the output.

# # Check memory is at least 4GB
# $ free -h
# # ... install with sudo apt-get install htop

# # Check server distribution is Ubuntu 16.04
# $  cat /etc/lsb-release
# DISTRIB_ID=Ubuntu
# DISTRIB_RELEASE=16.04
# DISTRIB_CODENAME=xenial
# DISTRIB_DESCRIPTION="Ubuntu 16.04.x LTS"

# # Next, check that your server is running the 64-bit version of Ubuntu 16.04.
# $ uname -m
# x86_64

# # Next, check that your server supports IPV6.
# $ ip addr | grep inet6
# inet6 ::1/128 scope host
# ...

# If you do not see the line inet6 ::1/128 scope host then after you install BigBlueButton you will need to modify the configuration for FreeSWITCH to disable support for IPV6 : https://docs.bigbluebutton.org/2.2/troubleshooting.html#freeswitch-fails-to-bind-to-port-8021

# # Next, check that your server is running Linux kernel 4.x.
# $ uname -r
# 4.15.0-38-generic

# # Next, check that your server has (at least) 4 CPU cores
# $ cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l
# 4

# # Check that multiverse repository is enabled
# $ grep "multiverse" /etc/apt/sources.list
# # ... should see uncommented line for repo: e.g. deb http://archive.ubuntu.com/ubuntu xenial multiverse

# # If multiverse is not enabled, run the following command to enable:
# $ echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" | sudo tee -a /etc/apt/sources.list

# # If you are a developer installing BigBlueButton on a VM for testing and development,
# # some of BigBlueButton’s components, such as # Tomcat, need a source of entropy when starting up.
# # In a VM the available entropy can run low Tomcat can block for a long periods of time (sometimes minutes)
# # before finishing its start-up. To give the VM lots of entropy, install a packaged called haveged (a simple entropy daemon):

# $ sudo apt-get install haveged

# # There are three applications needed by BigBlueButton: ffmpeg (create recordings), yq (update YAML files),
# # and libreoffice (for conversion). The default version of ffmpeg in Ubuntu 16.04 is old and yq does not exist
# # in the default repositories. Therefore, before you install BigBlueButton, you need to add the following
# #  personal package archives (PPA) to your server to ensure you get the proper versions installed.
# $ sudo add-apt-repository ppa:bigbluebutton/support -y
# $ sudo add-apt-repository ppa:rmescandon/yq -y
# $ sudo add-apt-repository ppa:libreoffice/ppa

# # Next, upgrade your server to the latest packages (and security fixes).
# $ sudo apt-get update
# $ sudo apt-get dist-upgrade

# # Reboot the server
# sudo reboot

printf "%s"


# =========================================================================================================================
# Code snippets

## Check the exit status
# cd "$some_directory"
# if [ "$?" = "0" ]; then
#   rm *
# else
#   echo "Cannot change directory!" 1>&2
#   exit 1
# fi


# #--- CHECK FOR ELEVATED PRIVILEGES
# if [ "$EUID" -ne 0 ]; then
#   echo -e "\nPlease run as this script as root\n"
#   exit 0;
# fi

# #--- INSTALLATION CONFIRMATION
# echo -e "\nThis script is specifically for installing Moodle v3.7 on Ubuntu Server 18.04\n"
# read -p "Do you wish to continue (y/n) : " RESPONSE
# #RESPONSE='y'

# if [ "$RESPONSE" == "y" ] || [ "$RESPONSE" == "Y" ]; then
#   echo -e "\nRunning script..."
# else
#   echo -e "\nExiting.\n"
#   exit 0;
# fi

# #--- RUN UPDATES
# echo ""
# CMD=$( echo -e "Updating..." | tee /dev/tty )
# #echo -e "\nUpdating..."
# echo apt-get update && apt-get upgrade -y
# checkLastCommand "$?" "$CMD" "$LINENO"

# #if [ $? -eq 0 ]; then
# #  echo -e "\nUpdates complete..."
# #else
# #  echo -e "\nUpdates failed with exit status: $?\n"
# #  exit 1;
# #fi

# #--- CHECK UNATTENDED UPGRADES IS ENABLED
# echo -e "\nChecking unattended upgrades..."
# TEMP="$(grep '"0"' /etc/apt/apt.conf.d/20auto-upgrades)"
# cat /etc/apt/apt.conf.d/20auto-upgrades

# if [ -z "$TEMP" ]; then
#   echo -e "Unattended upgrades OK"
# else
#   echo -e "\nUnattended upgrades not enabled. Please correct in /etc/apt/apt.conf.d/20auto-upgrades and restart script\n"
#   echo -e "Script failed at line $LINENO : exit status: $?\n"
#   exit 1;
# fi