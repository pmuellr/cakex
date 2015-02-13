# Licensed under the Apache License. See footer for details.

cakex = require "./lib/cakex"

#-------------------------------------------------------------------------------
task "watch", "watch for changes, build, test", ->

  onChanged()

  watch
    files: ["lib-src/**/*.coffee", "tests/**/*"]
    run:   onChanged

  watch
    files: "Cakefile"
    run: (file) ->
      return unless file == "Cakefile"
      log "Cakefile changed, exiting"
      process.exit 0


#-------------------------------------------------------------------------------
onChanged = ->
  invoke "build"
  invoke "test"

#-------------------------------------------------------------------------------
task "build", "build JavaScript from CoffeeScript", ->
  log "building ..."

  cleanDir "lib"
  coffee "--bare --compile --map --output lib lib-src/*.coffee"

#-------------------------------------------------------------------------------
task "test", "run tests", ->
  log "testing ..."

  origDir = pwd()

  try
    cd "tests/daemon"

    cd "../modfns"
    exec "../../node_modules/.bin/cake test"

    cd "../watch"
    exec "../../node_modules/.bin/cake test"

    cd "../daemon"
    exec "../../node_modules/.bin/cake test"

  finally
    cd origDir

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
