#!/bin/bash

mkdir roles/$1
mkdir roles/$1/tasks
mkdir roles/$1/files
mkdir roles/$1/handlers
mkdir roles/$1/templates
mkdir roles/$1/vars
mkdir roles/$1/defaults
mkdir roles/$1/meta


touch roles/$1/tasks/main.yml


