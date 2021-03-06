# circleci-cli <sub><sup>| Powerful CircleCI CLI via pure bash</sup></sub>
[![version](http://img.shields.io/badge/version-v0.8.1-blue.svg)](https://github.com/rockymadden/circleci-cli/releases)
[![versioning](http://img.shields.io/badge/versioning-semver-blue.svg)](http://semver.org/)
[![branching](http://img.shields.io/badge/branching-github%20flow-blue.svg)](https://guides.github.com/introduction/flow/)
[![license](http://img.shields.io/badge/license-mit-blue.svg)](https://opensource.org/licenses/MIT)
[![pm](http://img.shields.io/badge/pm-zenhub-blue.svg)](https://www.zenhub.io/)
[![chat](http://img.shields.io/badge/chat-slack-blue.svg)](https://rockymadden-slack.herokuapp.com/)
[![circleci](http://img.shields.io/badge/circleci-passing-brightgreen.svg)](https://circleci.com/gh/rockymadden/circleci-cli)

A pure bash, feature rich command line interface for [CircleCI](https://circleci.com).

__Sample use cases:__

* Programmatically interact with the CircleCI API
* OS X notification integration (i.e. each `git push` to GitHub notifies you about the eventual
  CircleCI build success or failure)
   * Add alias: `alias gpn='f() { git push && { sleep 10 ; circleci notify; } &; }; f'`
   * Push with notifications: `gpn`
* Perform advanced filtering/querying upon JSON responses to do things that are not possible via
  the UI
  * View build numbers of successful builds: `circleci builds --filter '.[] | select(.status=="success") | .build_num'`
* Perform advanced filtering upon JSON responses to do piped operations back into `circleci-cli`
  and/or other CLIs (e.g. find failed builds and re-trigger them, find successful builds and feed
  into a dashboard)

## Installation

### Via `brew`:

```bash
$ brew tap rockymadden/rockymadden
$ brew install circleci-cli
```

### Via `curl`:

```bash
$ curl -O https://raw.githubusercontent.com/rockymadden/circleci-cli/master/src/circleci
$ chmod 755 circleci
```

> __PROTIP:__ You are responsible for having `stedolan/jq` and `github/hub` on your `$PATH`.

### Via `make`:

```bash
$ git clone git@github.com:rockymadden/circleci-cli.git
$ cd circleci-cli
$ make install bindir=/path/to/bin etcdir=/path/to/etc
```

> __PROTIP:__ You are responsible for having `stedolan/jq` and `github/hub` on your `$PATH`.

## Configuration

Ensure you have a [CircleCI API token](https://circleci.com/account/api) and use said token one of
the following ways:

### Via `init`:

```bash
$ circleci init
```

### Via environment variable:

```bash
export CIRCLECI_CLI_TOKEN='token'
```

## Usage

```bash
$ circleci --help
Usage:
  circleci artifacts <project> <build>
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--trace|-x]

  circleci await <project> <build>
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--resolution|-r <seconds>]
    [--trace|-x]

  circleci browse <project> [build]
    [--trace|-x]

  circleci build <project> <build>
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--trace|-x]

  circleci builds <project>
    [--compact|-c] [--filter|-f <filter>] [--limit|-l <limit>] [--monochrome|-m]
    [--offset|-o <offset>] [--trace|-x]

  circleci cancel <project> <build>
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--trace|-x]

  circleci init
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--token|-t <token>]
    [--trace|-x]

  circleci me
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--trace|-x]

  circleci notify <project> <build>
    [--resolution|-r <seconds>] [--trace|-x]

  circleci project <project>
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--trace|-x]

  circleci projects
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--trace|-x]

  circleci retry <project> <build>
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--trace|-x]

  circleci trigger <project> <branch>
    [--compact|-c] [--filter|-f <filter>] [--monochrome|-m] [--parameter-key|-K <key>]
    [--parameter-value|-V <value>] [--revision|-R <revision>] [--trace|-x]

Configuration Commands:
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

More Information:
  chat    https://rockymadden-slack.herokuapp.com/
  repo    https://github.com/rockymadden/circleci-cli
```

> __PROTIPS:__
* Project names are represented as a combination of username and project name
(e.g. rockymadden/circleci-cli).
* `--` can be used as a placeholder for the current project, when inside a GitHub-based git repo.
* Project placeholder is implicitly applied, when not provided and inside a GitHub-based git repo.
* `--` can be used as a placeholder for the most recent build.
* Build placeholder is implicitly applied, when not provided.
* `--` can be used as a placeholder for the current branch, when inside a git repo.
* Branch placeholder is implicitly applied, when not provided and inside a git repo.
* The `--compact` option is a wrapper around the [jq](https://stedolan.github.io/jq/manual/)
  `--compact-output` option
* The `--filter` option is passed directly to [jq](https://stedolan.github.io/jq/manual/) as a
  filter
* The `--monochrome` option a wrapper around the [jq](https://stedolan.github.io/jq/manual/)
  `--monochrome-output` option
* All commands prompt for required arguments which were not provided via options or arguments. This
  allows for both traditional usage and prompt-based usage.

### `artifacts`:

```bash
$ # Implicit project and build:
$ circleci artifacts

$ # Placeheld project and build:
$ circleci artifacts -- --

$ # Placeheld project and explicit build:
$ circleci artifacts -- 1

$ # Explicit project and build:
$ circleci artifacts rockymadden/circleci-cli 1
```

### `await`:

```bash
$ # Implicit project and build:
$ circleci await

$ # Placeheld project and build:
$ circleci await -- --

$ # Placeheld project and explicit build:
$ circleci await -- 1

$ # Explicit project and build:
$ circleci await rockymadden/circleci-cli 1

$ # With filter:
$ circleci await --filter='.build_num'
```

### `browse`:

```bash
$ # Implicit project and build:
$ circleci browse

$ # Placeheld project and build:
$ circleci browse -- --

$ # Placeheld project and explicit build:
$ circleci browse -- 1

$ # Explicit project and build:
$ circleci browse rockymadden/circleci-cli 1
```

### `build`:

```bash
$ # Implicit project and build:
$ circleci build

$ # Placeheld project and build:
$ circleci build -- --

$ # Placeheld project and explicit build:
$ circleci build -- 1

$ # Explicit project and build:
$ circleci build rockymadden/circleci-cli 1

$ # With filter:
$ circleci build --filter='.build_num'
```

### `builds`:

```bash
$ # Implicit project:
$ circleci builds

$ # Placeheld project:
$ circleci builds --

$ # Explicit project:
$ circleci builds rockymadden/circleci-cli

$ # With filter:
$ circleci builds --filter='.[] | .build_num'
```

### `cancel`:

```bash
$ # Implicit project and build:
$ circleci cancel

$ # Placeheld project and build:
$ circleci cancel -- --

$ # Placeheld project and explicit build:
$ circleci cancel -- 1

$ # Explicit project and build:
$ circleci cancel rockymadden/circleci-cli 1

$ # With filter:
$ circleci cancel --filter='.status'
```

### `me`:

```bash
$ # With filter:
$ circleci me --filter='.login'
```

### `notify`:

```bash
$ # Implicit project and build:
$ circleci notify

$ # Placeheld project and build:
$ circleci notify -- --

$ # Placeheld project and explicit build:
$ circleci notify -- 1

$ # Explicit project and build:
$ circleci notify rockymadden/circleci-cli 1
```

### `project`:

```bash
$ # Implicit project:
$ circleci project

$ # Placeheld project:
$ circleci project --

$ # Explicit project:
$ circleci project rockymadden/circleci-cli

$ # With filter:
$ circleci project --filter='.username + "/" + .reponame'
```

### `projects`:

```bash
$ # With filter:
$ circleci projects --filter='.[] | .username + "/" + .reponame'
```

### `retry`:

```bash
$ # Implicit project and build:
$ circleci retry

$ # Placeheld project and build:
$ circleci retry -- --

$ # Placeheld project and explicit build:
$ circleci retry -- 1

$ # Explicit project and build:
$ circleci retry rockymadden/circleci-cli 1

$ # With filter:
$ circleci retry --filter='.status'
```

### `trigger`:

```bash
$ # Implicit project and branch:
$ circleci trigger

$ # Placeheld project and branch:
$ circleci trigger -- --

$ # Placeheld project and explicit branch:
$ circleci trigger -- master

$ # Explicit project and branch:
$ circleci trigger rockymadden/circleci-cli master

$ # With build parameters:
$ circleci trigger --parameter-key=key1 --parameter-value=val1 --parameter-key=key2 --parameter-value=val2

$ # With build parameters (short form):
$ circleci trigger -K key1 -V val1 -K key2 -V val2

$ # With revision:
$ circleci trigger --revision=634f9656ccf6e0cad7385782e776569bddbf84d6

$ # With revision (short form):
$ circleci trigger -R 634f9656ccf6e0cad7385782e776569bddbf84d6

$ # With filter:
$ circleci trigger --filter='.vcs_revision'

$ # With filter (short form):
$ circleci trigger -f '.vcs_revision'
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
