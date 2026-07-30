# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Collection of bash scripts and configuration for git workflow automation and project initialization. No build system or tests — all scripts are standalone bash.

## Script Conventions

- All scripts use `#!/usr/bin/env bash` and `set -e`.
- Scripts support `-h`/`--help` flags for usage info.
- Scripts that take no arguments check `$# -ne 0` and print usage on unexpected args.
- Output uses `echo` with `***` prefix for major steps in init scripts, and `- ` prefix for status lines in git scripts.
- Git aliases in `my-.gitconfig` invoke scripts via `!sh git-<name>`.
