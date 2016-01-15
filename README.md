# circleci-cli <sub><sup>| Powerful CircleCI CLI via pure bash</sup></sub>
[![version](http://img.shields.io/badge/version-v0.0.0-blue.svg)](https://github.com/rockymadden/circleci-cli/releases)
[![versioning](http://img.shields.io/badge/versioning-semver-blue.svg)](http://semver.org/)
[![branching](http://img.shields.io/badge/branching-github%20flow-blue.svg)](https://guides.github.com/introduction/flow/)
[![license](http://img.shields.io/badge/license-mit-blue.svg)](https://opensource.org/licenses/MIT)
[![slack](http://img.shields.io/badge/slack-join-e01563.svg)](https://rockymadden-slackin.herokuapp.com/)
[![circleci](https://circleci.com/gh/rockymadden/circleci-cli.svg?style=shield)](https://circleci.com/gh/rockymadden/circleci-cli)

A simple, yet extremely flexible command line interface for [CircleCI](https://circleci.com). Deep
integration with [jq](https://github.com/stedolan/jq) allows for the ability to perform complex
declarative/higher-order operations on responses, helping you perform complex piping/compositional
operations with relative ease.

__Example of richly formatted JSON output, which comes by default:__
![rich json](http://share.rockymadden.com/463u2x0z0j1v/Image%202016-01-14%20at%2011.36.39%20AM.png)

__Example of filtering capabilities:__
![rich json](http://share.rockymadden.com/0c210D3Q0u2g/Image%202016-01-14%20at%2011.37.16%20AM.png)

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
  circleci browse <project> [build|branch]
  circleci build <project> <build> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci builds <project> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci cancel <project> <build> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci init [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--token|-t <token>]
  circleci me [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci notify <project> <build>
  circleci project <project> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci projects [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci retry <project> <build> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
  circleci trigger <project> <branch> [--compact|-c] [--filter|-f <filter>] [--monochrome|-m]
    [--parameters|-P <parameters>]

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

> __PROTIP:__ Project names are represented as combination of username and project name
(e.g. rockymadden/circleci-cli).

> __PROTIP:__ If you are in a git repo, you can use the `--` shorthand in place of the actual
project name.

> __PROTIP:__ Filters are simply [jq](https://github.com/stedolan/jq) filters, you can provide any
filter that it can handle.

> __PROTIP:__ All commands prompt for required arguments which were not provided via options or
arguments. This allows for both traditional usage and prompt-based usage.

## Examples and Recipes

### OS X notification when a build succeeds or fails:
```bash
$ circleci notify rockymadden/circleci-cli 2
```

![example](http://share.rockymadden.com/1h2w3x2u2B0f/Screen%20Recording%202016-01-14%20at%2011.24%20AM.gif)

### Simple list of projects for further processing (e.g. xargs back into circleci-cli):
```bash
$ circleci projects --filter='.[] | .username + "/" + .reponame'
rockymadden/circleci-cli
rockymadden/slack-cli
...
```

> __PROTIP:__ Filters are simply [jq](https://stedolan.github.io/jq/manual/) filters, you can
provide any filter that it can handle.

### Using project shorthand while inside git repo:
```bash
$ circleci project --
$ circleci builds --
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
