#!/bin/sh

set -e

min_ver="3.2"
directory=()
latest=""
alpine_version=""

get_all_tags () {
  echo "======> Getting all alpine tags"
  directory=( `curl -s https://hub.docker.com/v2/repositories/library/alpine/tags/?page_size=100 | \
                jq '.results | .[] | .name' | sort | sed -E 's/"//g' | sed -E 's/latest//g' | tr '\n' ' '` )

  echo "  Found : ${directory[@]}"
  echo " "
  echo "  Support start at $min_ver deleting previous version form array"

  local j=0
  for i in ${directory[@]}
  do
    if [ "$i" = "$min_ver" ] ; then
      break;
    fi
    unset 'directory[j]'
    ((j++))
  done

  latest=${directory[(${#directory[@]})-2]}

  echo " "
  echo "  Final array : ${directory[@]}"
  echo "  Latest stable version is $latest"
  echo " "
}

dockerfile (){
  echo "  ======> Generating Dockerfile"
  sed -e "s/@ALPINE_VERSION@/$alpine_version/" Dockerfile > $alpine_version/Dockerfile
}

assets () {
  echo "  ======> Adding assets"

  rm -Rf $alpine_version/assets
  mkdir $alpine_version/assets

  cp -R assets/common/* $alpine_version/assets

  if [ -d assets/$alpine_version ]; then
    echo "    ======> Adding specific assets"
    cp -R assets/$alpine_version/* $alpine_version/assets
  fi
}

build () {
  echo "  ======> Building image"
  local tags="-t amary/base:$alpine_version"

  if [ "$alpine_version" = "$latest" ]; then
    echo "    ======> This image is the latest"
    tags+=" -t amary/base:latest"
  fi

  docker build $tags ./$alpine_version || true
}

main () {
  if [ $# -eq 0 ]
  then
    echo "======> No arguments supplied"
    get_all_tags
  else
    echo "======> arguments supplied"
    get_all_tags
  fi

  local i=""
  for i in ${directory[@]}
  do
    alpine_version=$i
    echo "======> Alpine $alpine_version"

    mkdir -p $alpine_version
    dockerfile
    assets
    build
    echo " "
  done
}

main
