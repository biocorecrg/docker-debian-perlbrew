#!/bin/bash

set -ueo pipefail

SOURCE=https://github.com/CRG-CNAG/docker-debian-perlbrew
VARIANTS=(base pyenv pyenv3 java)
BRANCHES=(jessie latest)
BASETAG=biocorecrg/debian-perlbrew

TEMPDIR=$HOME/tmp
WORKDIR=$TEMPDIR/docker-debian-perlbrew

mkdir -p $WORKDIR


function dockerBuildPush () {

	cd $1
	TAG=""
        if [ "${1}" != "base" ]; then
        	TAG=":$1"
	fi
 
	docker build -t $2$TAG .
	docker push $2$TAG	
}


# Iterate branches
for i in ${BRANCHES[@]}; do
	
	cd $WORKDIR

	mkdir ${i}

	CURDIR=$WORKDIR/$i
	cd ${CURDIR}
	
	git clone $SOURCE	

	BRANCH=$i
	if [ "${BRANCH}" == "latest" ]; then
		BRANCH=master
	fi

	git checkout $BRANCH

	for v in ${VARIANTS[@]}; do
		cd $CURDIR
		dockerBuildPush $v $BASETAG
	done
			
done

# Clean everything
rm -rf $WORKDIR

