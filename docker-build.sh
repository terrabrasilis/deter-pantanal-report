#!/bin/bash

NO_CACHE=""
echo "Do you want to build using docker cache from previous build? Type yes to use cache." ; read BUILD_CACHE
if [[ ! "$BUILD_CACHE" = "yes" ]]; then
    echo "Using --no-cache to build the image."
    echo "It will be slower than use docker cache."
    NO_CACHE="--no-cache"
else
    echo "Using cache to build the image."
    echo "Nice, it will be faster than use no-cache option."
fi

VERSION=$(git describe --tags --abbrev=0)

echo 
echo "/######################################################################/"
echo " Build new image terrabrasilis/deter-pantanal-app:$VERSION "
echo "/######################################################################/"
echo

docker build $NO_CACHE -t "terrabrasilis/deter-pantanal-app:$VERSION" -f env-php/Dockerfile app/

# send to dockerhub
echo 
echo "The building was finished! Do you want sending these new images to Docker HUB? Type yes to continue." ; read SEND_TO_HUB
if [[ ! "$SEND_TO_HUB" = "yes" ]]; then
    echo "Ok, not send the images."
else
    echo "Nice, sending the images!"
    docker push "terrabrasilis/deter-pantanal-app:$VERSION"
fi