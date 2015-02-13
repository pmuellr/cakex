# Licensed under the Apache License. See footer for details.

fs   = require "fs"
path = require "path"

_      = require "underscore"
require "shelljs/global"

pkg    = require "../package.json"
daemon = require "./daemon"
watch  = require "./watch"

cakex = exports

PROGRAM = path.relative(process.cwd(), require.main.filename)

#-------------------------------------------------------------------------------
main = ->
  exports._                     = _
  exports.fs                    = fs
  exports.path                  = path

  exports.log                   = log
  exports.watch                 = watch.watch
  exports.daemon                = daemon
  exports.defineModuleFunctions = defineModuleFunctions

  for name, val of exports
    global[name] = val

  defineModuleFunctions "."

  return

#-------------------------------------------------------------------------------
defineModuleFunctions = (dir) ->
  nodeModulesBin = path.join dir, "node_modules", ".bin"

  scripts = getNodeModulesScripts nodeModulesBin

  for scriptName in scripts
    sanityName = sanitizeFunctionName scriptName
    fn         = invokeNodeModuleScript nodeModulesBin, scriptName

    addGlobalFn scriptName, fn
    addGlobalFn sanityName, fn

  return

#-------------------------------------------------------------------------------
addGlobalFn = (name, fn) ->
  return if global[name]?
  global[name] = fn

#-------------------------------------------------------------------------------
getNodeModulesScripts = (dir) ->
  return [] unless test "-d", dir

  result  = {}
  scripts = ls dir
  for script in scripts
    name = script.split(".")[0]
    result[name] = name

  return _.keys result

#-------------------------------------------------------------------------------
invokeNodeModuleScript = (scriptPath, script) ->
  script = "#{script}.cmd" if (process.platform is "win32")

  return (commandArgs, execArgs...) ->
    command = "#{path.join scriptPath, script} #{commandArgs}"

    execArgs.unshift command

    exec.apply null, execArgs

    return

#-------------------------------------------------------------------------------
sanitizeFunctionName = (scriptName) ->
  return scriptName.replace(/[^\d\w_$]/g, "_")

#-------------------------------------------------------------------------------
log = (message) ->
  if !message? or message is ""
    console.log ""
  else
    console.log "#{PROGRAM}: #{getTime()}: #{message}"
  return

#-------------------------------------------------------------------------------
getTime = ->
  return new Date().toLocaleTimeString()

#-------------------------------------------------------------------------------
main()


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
