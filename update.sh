#!/usr/bin/env bash

_update_full_head() {
    hr install head-hr $@
    hr install head $@
    hr update head
    hr clean head
    hr build head
}
