#!/bin/bash

echo Cleaning...
rm -rf ./build

if [ -z "$GIT_COMMIT" ]; then
  export GIT_COMMIT=$(git rev-parse HEAD)
  export GIT_URL=$(git config --get remote.origin.url)
fi

# Remove .git from url in order to get https link to repo (assumes https url for GitHub)
export GITHUB_URL=$(echo $GIT_URL | rev | cut -c 5- | rev)


echo Building app
npm run build

rc=$?
if [[ $rc != 0 ]] ; then
    echo "Npm build failed with exit code " $rc
    exit $rc
fi

cp ./Dockerfile ./build/

echo Building docker image

docker build -t jongrjon/tictactoe:$GIT_COMMIT .

rc=$?
if [[ $rc != 0 ]] ; then
    echo "Docker build failed " $rc
    exit $rc
fi

#docker push jongrjon/tictactoe:$GIT_COMMIT
#rc=$?
#if [[ $rc != 0 ]] ; then
#    echo "Docker push failed " $rc
#    exit $rc
#fi