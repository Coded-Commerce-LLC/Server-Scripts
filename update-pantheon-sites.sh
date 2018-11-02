#!/bin/bash

sites=( "one" "two" "three" );

for i in "${sites[@]}";
	do
		terminus wp $i.dev -- plugin update --all \
		&& terminus wp $i.dev -- theme update --all \
		&& terminus wp $i.dev -- core update \
		&& terminus wp $i.dev -- transient delete --all \
		&& terminus wp $i.dev -- cache flush
done;
