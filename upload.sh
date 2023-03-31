#!/bin/bash

set -e

podman=podman
if ! which $podman; then
  podman=docker
fi

img_version=$1
registry=${2:-registry.prehensile-tales.com}
godot_nonfree=0

if [ -z "${img_version}" ]; then
  echo "No image version was provided, aborting. Check script for usage."
  exit 1
fi

$podman push godot/build/export:${img_version} ${registry}/build/export:${img_version}
$podman push godot/build/linux:${img_version} ${registry}/build/linux:${img_version}
$podman push godot/build/windows:${img_version} ${registry}/build/windows:${img_version}
$podman push godot/build/web:${img_version} ${registry}/build/web:${img_version}
$podman push godot/build/android:${img_version} ${registry}/build/android:${img_version}

if [ "${godot_nonfree}" != "0" ]; then
  $podman push godot/build/xcode:${img_version} ${registry}/build/xcode:${img_version}
  $podman push godot/build/ios:${img_version} ${registry}/build/ios:${img_version}
  $podman push godot/build/osx:${img_version} ${registry}/build/macosx:${img_version}
  $podman push godot/build/msvc:${img_version} ${registry}/build/uwp:${img_version}
fi
