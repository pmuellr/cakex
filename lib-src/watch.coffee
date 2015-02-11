# Licensed under the Apache License. See footer for details.

fs   = require "fs"
path = require "path"

_    = require "underscore"
Gaze = require("gaze").Gaze

cakex = require("./cakex")

#-------------------------------------------------------------------------------
exports.watch = ({fileSpecs, run}) ->
  gaze = new Gaze(fileSpecs)

  #------------------------------------
  gaze.watched (err, files) ->
    if err?
      log "error getting watched files: #{err}"
      return

    log "watching #{files.length} files for changes ..."

  #------------------------------------
  gaze.on "all", (event, file) ->
    if file?
      cakex.log "----------------------------------------------------"
      cakex.log "file changed: #{file} on #{new Date}"

    try
      run file
    catch err
      cakex.log "error running watch function: #{err}"
      cakex.log err.stack

    gaze.close()

    exports.watch {fileSpecs, run}

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
