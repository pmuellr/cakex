# Licensed under the Apache License. See footer for details.

child_process = require "child_process"

daemon = exports

Daemons = {}

process.on "uncaughtException", (err) ->
  log "uncaughtException: #{err}"
  log e.stack

process.on "exit",              -> killAll()
process.on "SIGTERM",           -> killAll()
process.on "SIGINT",            -> killAll()
process.on "SIGBREAK",          -> killAll()
process.on "uncaughtException", -> killAll()

#-------------------------------------------------------------------------------
daemon.start = (handle, program, args, options={}) ->
  daemon.kill handle, ->

    options.stdio ?= "inherit"

    serverProcess = child_process.spawn program, args, options

    Daemons[handle] = serverProcess

    # log "daemon.start: started #{serverProcess.pid}"

    serverProcess.on "exit", ->
      delete Daemons[handle]
      # log "daemon.start: exited  #{serverProcess.pid}"

  return

#-------------------------------------------------------------------------------
daemon.kill = (handle, cb) ->
  serverProcess = Daemons[handle]

  unless serverProcess?
    cb() if cb?
    return

  delete Daemons[handle]

  serverProcess.on "exit", ->
    # log "daemon.kill:  killed  #{serverProcess.pid}"
    cb() if cb?

  # log "daemon.kill:  killing #{serverProcess.pid}"
  serverProcess.kill()

  return

#-------------------------------------------------------------------------------
killAll = ->
  for handle, serverProcess of Daemons
    serverProcess.kill()

  exit()

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
