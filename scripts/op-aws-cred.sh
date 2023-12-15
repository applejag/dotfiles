#!/usr/bin/env bash

OP_ITEM="${1:?'Missing first arg'}"
op item get --format=json "$OP_ITEM" \
	| jq '
		.fields
		| map({(.label): .})
		| add
		| {
			Version: 1,
			AccessKeyId: ."access key id".value,
			SecretAccessKey: ."secret access key".value,
		}'
