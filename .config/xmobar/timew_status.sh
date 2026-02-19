#!/bin/bash

output=$(timew)

if echo "$output" | grep -q "There is no active time tracking."; then
	echo "Idle"
else
	current_tag=$(echo "$output" | sed -n 's/^Tracking //p')
	total_time=$(echo "$output" | awk '/Total/ {print $2}')

	echo "$current_tag: $total_time"
fi
