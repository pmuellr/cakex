# Licensed under the Apache License. See footer for details.

child_process = require "child_process"

daemon = exports

AllServers = []

process.on "exit",              -> killAll()
process.on "beforeExit",        -> killAll()
process.on "uncaughtException", -> killAll()
process.on "SIGINT",            -> killAll()
process.on "SIGTERM",           -> killAll()
process.on "SIGTBREAK",         -> killAll()

#-------------------------------------------------------------------------------
daemon.start = (pidFile, program, args, options={}) ->
  daemon.kill pidFile, ->

    options.stdio ?= "inherit"

    serverProcess = child_process.spawn program, args, options

    serverProcess.pid.toString().to pidFile

    serverAdd pidFile

  return

#-------------------------------------------------------------------------------
daemon.kill = (pidFile, cb) ->
  serverRemove pidFile

  if test "-f", pidFile
    pid = cat pidFile
    pid = parseInt pid, 10
    rm pidFile

    try
      process.kill pid
    catch e

  process.nextTick -> cb() if cb?

  return

#-------------------------------------------------------------------------------
serverAdd = (pidFile) ->
  AllServers.push pidFile

#-------------------------------------------------------------------------------
serverRemove = (pidFile) ->
  index = AllServers.indexOf pidFile
  return if index == -1

  AllServers.splice index, 1

#-------------------------------------------------------------------------------
killAll = ->
  for pidFile in AllServers.slice()
    daemon.kill pidFile

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
