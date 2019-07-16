#!/bin/bash

set -e

GITHUB=https://github.com/
ROBOT_REPO="${ROBOT_REPO:-ontodev/robot}"
ROBOT_GITHUB=$GITHUB$ROBOT_REPO".git"
BRANCH="${BRANCH:-master}"

echo $BRANCH
echo $ROBOT_GITHUB

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
echo $SCRIPTPATH

ODK_GITHUB=https://github.com/INCATools/ontology-development-kit.git

SUBDIR=target/$(date +"%Y_%m_%d_%I_%M_%p")"_"$BRANCH
DIR=$SCRIPTPATH/$SUBDIR
ROBOT_GH_RAW=https://raw.githubusercontent.com/monarch-ebi-dev/robot_test/master/$SUBDIR/robot.jar
mkdir $DIR

echo $DIR
cd $DIR && git clone $ROBOT_GITHUB && cd robot
git checkout $BRANCH
mvn clean package
cp $DIR/robot/bin/robot.jar $DIR
cd $SCRIPTPATH
git add $SUBDIR/robot.jar
git commit -m "new robot version"
git push
rm -rf $DIR/robot


cd $DIR && git clone $ODK_GITHUB
cd ontology-development-kit
git checkout odk_robot_param
docker build --build-arg ROBOT_JAR=$ROBOT_GH_RAW -t obolibrary/odkdev . \
&& docker tag obolibrary/odkdev:robot
cd $SCRIPTPATH
rm -rf $DIR/ontology-development-kit

