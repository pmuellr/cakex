# Licensed under the Apache License. See footer for details.

process.on "uncaughtException", (e) ->
  console.log e
  console.log e.stack

cakex = require "./lib/cakex"

#-------------------------------------------------------------------------------
task "watch", "watch for changes, build, test", ->

  console.log "starting watches"
  
  watch
    files: "lib-src/*.coffee"
    run: ->
      invoke "build"
      invoke "test"

  watch
    files: "Cakefile"
    run: ->
      log "Cakefile changed, exiting"
      process.exit 0

#-------------------------------------------------------------------------------
task "build", "build JavaScript from CoffeeScript", ->
  cleanDir "lib"
  coffee "--bare --compile --map --output lib lib-src/*.coffee"

#-------------------------------------------------------------------------------
task "test", "run tests", ->
  log "test: TBD"

#-------------------------------------------------------------------------------
cleanDir = (dir) ->
  mkdir "-p", dir
  rm "-rf", "#{dir}/*"

#-------------------------------------------------------------------------------
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#-------------------------------------------------------------------------------
