`cakex` - extended functionality for `cake`
================================================================================

If you currently use [CoffeeScript's `cake`](http://coffeescript.org/#cake)
utility as a project builder, the `cakex` package may be useful to you.  It
provides a number of useful functions to make it even easier to script your
builds.

`cakex` should be usable with other build tools as well.


using `cakex`
================================================================================

Add `cakex` to your `devDependencies` property of your `package.json` file.

Once added, you can access `cakex` from your `Cakefile` with a simple
require invocation:

    require "cakex"


globals that `cakex` adds
================================================================================

`cakex` adds a number of global functions to your running environment.

* Adds all of the functions in the
  [`shelljs` package](http://documentup.com/arturadib/shelljs)
  as global functions. Eg, you can use `ls()` to get a list of files.

* Adds `fs`, `path`, and `_` as global variables, whose values are
  `require("fs")`, `require("path")`, and `require("underscore")`.

* Adds the `cakex` exported functions.  See below for more on these functions

* Adds a function for every "script" in your
  `node_modules/.bin` directory.  Any characters in those script names, which
  are not valid in JavaScript identifiers, will be converted to underscores,
  so you can reference them easily.  Any script names that still aren't legal
  JavaScript identifiers will need to be accessed from the `global`
  variable. Eg, access the script `6to5` as `global['6to5']`.

  The script functions are invocations of the `shelljs` function
  [`exec()`](http://documentup.com/arturadib/shelljs#command-reference/exec-command-options-callback)
  with the arguments passed to the functions appended to the script name. For
  example, if you call:

      browserify "foo"

  it will be invoked as:

      exec("node node_modules/.bin/browserify foo")

  You may also pass valid additional `exec()` arguments to the script functions.
  For example, if you call:

      browserify "foo", {silent: true}

  it will be invoked as:

      exec("node node_modules/.bin/browserify foo", {silent: true})



`cakex` exported functions
================================================================================

The following functions are exported from the `cakex` module, but also available
as globals.


`log(string)`
---------------------------------------

Writes a string to the console, prefixed by the name of the main program
running.  When called with no argument, prints a blank line.


`watch({files: gazeSpec, run: fn})`
---------------------------------------

The argument to this function should be an object with a `files` property and
a `run` property.

The `files` property should be a [`gaze`](https://www.npmjs.com/package/gaze)
pattern argument (string or array of strings).

The `run` property is a function that will be called when a file matching
the `files` patterns changes.  The function will be called with `this` set
to the argument of the `watch()` function.  

The watch will not respond to any other file changes until after the `run`
function completes.


`daemon.start(handle, program, args, options={})`
---------------------------------------

This function starts a background process with the `child_process.spawn()`
function, ensuring only one instance of the program
will be running for each unique handle. The first argument should be a handle
to refer to this server, for later use with `daemon.start()` or `daemon.kill()`.
The remaining arguments are the same as for the `child_process` function
[`spawn()`](http://nodejs.org/api/child_process.html#child_process_child_process_spawn_command_args_options).

`daemon.start()` will first call `daemon.kill()` with the same `handle`, to
ensure that an earlier invocation of the process is killed before the new
one starts.


`daemon.kill(handle, cb)`
---------------------------------------

This function will kill a background process started with `daemon.start()`.  If
a callback is passed, it will be invoked when the process has been killed (or
as near as we can guess).


`defineModuleFunctions(dir)`
---------------------------------------

This function will add scripts from a `node_modules/.bin` directory as global
functions, just as is done with with the `node_modules/.bin` in your current
directory by default.  In fact, those globals are added by invoking
`defineModuleFunctions(".")` when `cakex` starts.

If you have other `node_modules` directories that you'd like to add tools from,
you can do that with this function.

The argument to this function should be the directory that contains the relevant
`node_modules` directory.




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
