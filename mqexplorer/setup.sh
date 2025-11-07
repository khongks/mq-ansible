#!/bin/bash

useradd -m admin
usermod -aG mqm admin
passwd admin
