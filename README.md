# circleci-cli <sub><sup>| CircleCI CLI via pure bash</sup></sub>
[![version](http://img.shields.io/badge/version-v0.4.0-blue.svg)](https://github.com/rockymadden/circleci-cli/releases)
[![versioning](http://img.shields.io/badge/versioning-semver-blue.svg)](http://semver.org/)
[![branching](http://img.shields.io/badge/branching-github%20flow-blue.svg)](https://guides.github.com/introduction/flow/)
[![license](http://img.shields.io/badge/license-mit-blue.svg)](https://opensource.org/licenses/MIT)
[![slack](http://img.shields.io/badge/slack-join-e01563.svg)](https://rockymadden-slack.herokuapp.com/)
[![circleci](https://circleci.com/gh/rockymadden/circleci-cli.svg?style=shield)](https://circleci.com/gh/rockymadden/circleci-cli)

A simple, yet extremely flexible command line interface for [CircleCI](https://circleci.com). Deep
integration with [jq](https://github.com/stedolan/jq) allows for the ability to perform complex
declarative/higher-order operations on responses, helping you perform complex piping/compositional
operations with relative ease (see the [integration tests](test/integration/circleci) for some
simple examples).

## Installation
```bash
# Install from tap:
$ brew tap rockymadden/rockymadden
$ brew install circleci-cli

# Initialize with your CircleCI API token:
$ circleci init
Enter token: <your token>
```

> __PROTIP:__ Ensure you have a [CircleCI API token](https://circleci.com/account/api).

## Usage
```bash
$ circleci --help
Usage:
  circleci artifacts <project> <build> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci await <project> <build> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
    [--resolution|-r <seconds>]
  circleci browse <project> [build]
  circleci build <project> <build> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci builds <project> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci cancel <project> <build> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci init [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--token|-t <token>]
  circleci me [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci notify <project> <build> [--resolution|-r <seconds>]
  circleci project <project> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci projects [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci retry <project> <build> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci trigger <project> <branch> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
    [--parameter-key|-K <key>] [--parameter-value|-V <value>] [--revision|-R <revision>]

Setup Commands:
  init    Initialize

Core Commands:
  artifacts    List the artifacts produced by a given build for a given project
  build        Details of a given build for a given project
  builds       Details of all builds for a given project
  cancel       Cancel a given build for a given project
  me           Details of the given user
  project      Details of a given project
  projects     List projects of the given user
  retry        Retry a given build for a given project
  trigger      Trigger a new build of a given branch for a given project

Convenience Commands:
  await     Await success or failure of a given build for a given project
  browse    Open CircleCI page of a given project
  notify    Await success or failure of a given build for a given project and create an OS X
            notification with the details
```

> __PROTIPS:__
* Project names are represented as a combination of username and project name
(e.g. rockymadden/circleci-cli).
* `--` can be used as a placeholder for the project, when inside a GitHub-based git repo.
* Project placeholder is implicitly applied, when not provided and inside a GitHub-based git repo.
* `--` can be used as a placeholder for the most recent build.
* Build placeholder is implicitly applied, when not provided.
* Filters are simply [jq filters](https://stedolan.github.io/jq/manual/), you can provide any filter
that it can handle.
* All commands prompt for required arguments which were not provided via options or arguments. This
allows for both traditional usage and prompt-based usage.

## Examples and Recipes

### `artifacts`:

```bash
# Implicit project and build:
$ circleci artifacts
# Placeheld project and build:
$ circleci artifacts -- --
# Explicit project and build:
$ circleci artifacts rockymadden/circleci-cli 1
```

### `await`:

```bash
# Implicit project and build:
$ circleci await
# Placeheld project and build:
$ circleci await -- --
# Explicit project and build:
$ circleci await rockymadden/circleci-cli 1
# Custom filter:
$ circleci await --filter='.build_num'
```

### `browse`:

```bash
# Implicit project and build:
$ circleci browse
# Placeheld project and build:
$ circleci browse -- --
# Explicit project and build:
$ circleci browse rockymadden/circleci-cli 1
```

### `build`:

```bash
# Implicit project and build:
$ circleci build
# Placeheld project and build:
$ circleci build -- --
# Explicit project and build:
$ circleci build rockymadden/circleci-cli 1
# Custom filter:
$ circleci build --filter='.build_num'
```

### `builds`:

```bash
# Implicit project:
$ circleci builds
# Placeheld project:
$ circleci build --
# Explicit project:
$ circleci build rockymadden/circleci-cli
# Custom filter:
$ circleci builds --filter='.[] | .build_num'
```

### `cancel`:

```bash
# Implicit project and build:
$ circleci cancel
# Placeheld project and build:
$ circleci cancel -- --
# Explicit project and build:
$ circleci cancel rockymadden/circleci-cli 1
```

### `notify`:

```bash
# Implicit project and build:
$ circleci notify
# Placeheld project and build:
$ circleci notify -- --
# Explicit project and build:
$ circleci notify rockymadden/circleci-cli 1
```

### `project`:

```bash
# Implicit project:
$ circleci project
# Placeheld project:
$ circleci project --
# Explicit project:
$ circleci project rockymadden/circleci-cli
```

### `projects`:

```bash
# Custom filter:
$ circleci projects --filter='.[] | .username + "/" + .reponame'
```

### `retry`:

```bash
# Implicit project and build:
$ circleci retry
# Placeheld project and build:
$ circleci retry -- --
# Explicit project and build:
$ circleci retry rockymadden/circleci-cli 1
```

### `trigger`:

```bash
# Implicit project and explicit branch:
$ circleci trigger -- master
# Custom build parameters:
$ circleci trigger -- master --parameter-key=key1 --parameter-value=val1 --parameter-key=key2 --parameter-value=val2
# Custom revision:
$ circleci trigger -- master --revision=634f9656ccf6e0cad7385782e776569bddbf84d6
```

## License
```
The MIT License (MIT)

Copyright (c) 2016 Rocky Madden (https://rockymadden.com/)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
