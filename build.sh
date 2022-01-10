#!/bin/bash

set -ueo pipefail

SOURCE=https://github.com/CRG-CNAG/docker-debian-perlbrew
VARIANTS=(base pyenv pyenv3 pyenv-java pyenv3-java)
BRANCHES=(stretch buster)
LATEST=stretch
BASETAG=biocorecrg/debian-perlbrew

TEMPDIR=$HOME/tmp
WORKDIR=$TEMPDIR/docker-debian-perlbrew

if [ -d "$WORKDIR" ]; then
	exit 1
fi

mkdir -p $WORKDIR


function dockerBuildPush () {

	cd $1
	GROUP=""
	if [ "${1}" != "base" ]; then
        	GROUP="-$1"
	fi

	TAG=":$3"

    echo "--> $2$GROUP$TAG"
 
	docker build --no-cache -t $2$GROUP$TAG .
	docker push $2$GROUP$TAG    

	if [ "$3" == $LATEST ]; then
		echo "$$> $2$GROUP"
		docker build -t $2$GROUP .
		docker push $2$GROUP
    	fi

}


# Iterate branches
for i in ${BRANCHES[@]}; do
	
	cd $WORKDIR

    echo "** BRANCH ${i}"

	mkdir ${i}

	CURDIR=$WORKDIR/$i
	cd ${CURDIR}
	
	git clone $SOURCE .

	BRANCH=$i
	if [ "${BRANCH}" == ${LATEST} ]; then
		BRANCH=master
	fi

	git checkout $BRANCH

	for v in ${VARIANTS[@]}; do
		cd $CURDIR
        echo "## VARIANT $v"
		dockerBuildPush $v $BASETAG $i
	done

			
done

# Clean everything
rm -rf $WORKDIR

