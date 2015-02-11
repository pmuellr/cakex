`cakex` - extended functionality for `cake`
================================================================================

If you currently use [CoffeeScript's `cake`](http://coffeescript.org/#cake)
utility as a project builder, the `cakex` package may be useful to you.  It
provides a number of useful functions to make it even easier to script your
builds.



using `cakex`
================================================================================

Add `cakex` to your `devDependencies` property of your `package.json` file.

Once added, you can access `cakex` from your `Cakefile` with a simple
require invocation:

    cakex = require 'cakex'


globals that `cakex` adds
================================================================================

`cakex` adds a number of global functions to your running environment.

First, it pulls in all of the
[`shelljs` package](http://documentup.com/arturadib/shelljs).

Next, it adds each of the `scripts` in your `node_modules/.bin` directory as
functions.  Any characters in those script names, which are not valid in
JavaScript identifiers, will be converted to underscores, so you can reference
them directly.  Any script names that still aren't legal
JavaScript identifiers will need to be accessed from the `global`
variable.  

For example, access the script `6to5` as `global['6to5']`.

The script functions are invocations of the `shelljs` function
[`exec()`](http://documentup.com/arturadib/shelljs#command-reference/exec-command-options-callback)
with the arguments passed to the functions appended to the script name. For
example, if you call:

    `browserify "foo"`

it will be invoked as:

    exec("node node_modules/.bin/browserify foo")

You may also pass valid additional `exec()` arguments to the script functions.
For example, if you call:

    browserify "foo", {silent: true}

it will be invoked as:

    exec("node node_modules/.bin/browserify foo", {silent: true})



functions available within `cakex`
================================================================================





hacking
================================================================================

This project uses [CoffeeScript's `cake`](http://coffeescript.org/#cake) as it's
build tool.  To rebuild the project continuously, use the command:

    npm run watch

Other `cake` commands are available (assuming you are using npm v2) with
the command

    npm run cake -- <command here>

Run `npm run cake` to see the other commands available in the `Cakefile`.



license
================================================================================

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
