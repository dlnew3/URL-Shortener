#!/bin/bash
#
# Dennis Newman
# dlnew3@csu.fullerton.edu
# CPSC 254-99
#
# Script to facilitate the activation and deactivation of 
# the MySQL and Flask Docker Containers
# running "Flask-URL-Shortener" by GlowSquid
#
###############################################################################
#
# Usage
#
function usage () {
  echo "Usage:"
  echo "${0} [options]"
  echo "Options:"
  echo "start : Starts the Docker Containers using Port 8080."
  echo "stop : Stops any related Docker Containers."
  echo "status: Shows the status of related Docker Containers."
  echo
  echo "This script will start, stop, or display the status of Docker"
  echo "Containers which manage a MySQL database and Flask-URL-Shortener"
  echo "web application."
  echo
}
###############################################################################
#
# Main
#
SCRIPTNAME=`basename ${0}`

if [ ${#} -lt 1 ]; then
  usage ${SCRIPTNAME}
  exit 2
fi
################################################################################
#
# Help
#
function help (){
  echo "Help"
  usage ${SCRIPTNAME}
  exit 2
}
############################################################################################
#
# Start
#
PARAM=${1} 

if [ ${PARAM} == "start" ]; then
	docker-compose up --build &
elif [ ${PARAM} == "stop" ]; then
	VAR=$(grep "docker-compose" < <(ps) | sed -n 2p)
	VAR=${VAR:0:5}
	kill ${VAR}
elif [ ${PARAM} == "status" ]; then
	STATUS=$(docker container ls | grep "part2_web")
	if [ -z ${STATUS:0:14} ]; then
		echo "Container is not currently running"
	else
		echo "Container is running"
	fi
else
	usage ${SCRIPTNAME}
fi
