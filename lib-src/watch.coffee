# Licensed under the Apache License. See footer for details.

fs   = require "fs"
path = require "path"

_    = require "underscore"
Gaze = require("gaze").Gaze

cakex = require("./cakex")

#-------------------------------------------------------------------------------
exports.watch = ({files, run}) ->
  gaze = new Gaze(files)

  #------------------------------------
  cakex.log "watching #{countWatched gaze.relative()} files for changes ..."

  fired = false
  #------------------------------------
  gaze.on "all", (event, file) ->
    return if fired
    fired = true

    if file?
      cakex.log "----------------------------------------------------"
      file = path.relative process.cwd(), file
      cakex.log "file changed: #{file} on #{new Date}"

    try
      run file
    catch err
      cakex.log "error running watch function: #{err}"
      cakex.log err.stack

    gaze.close()

    exports.watch {files, run}

#-------------------------------------------------------------------------------
countWatched = (rFiles) ->
  count = 0

  for dir, files of rFiles
    count += files.length

  return count

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
