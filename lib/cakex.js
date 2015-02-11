// Generated by CoffeeScript 1.9.0
var cakex, coffee, daemon, defineModuleFunctions, fs, getNodeModulesScripts, invokeNodeModuleScript, log, main, path, pkg, sanitizeFunctionName, watch, _,
  __slice = [].slice;

fs = require("fs");

path = require("path");

_ = require("underscore");

coffee = require("coffee-script");

require("shelljs/global");

pkg = require("../package.json");

daemon = require("./daemon");

watch = require("./watch");

cakex = exports;

main = function() {
  var name, val;
  coffee.register();
  exports.daemon = daemon;
  exports.watch = watch.watch;
  exports.defineModuleFunctions = defineModuleFunctions;
  exports.log = log;
  for (name in exports) {
    val = exports[name];
    global[name] = val;
  }
  defineModuleFunctions(".");
};

defineModuleFunctions = function(dir) {
  var nodeModulesBin, sanitizedName, script, scripts, _i, _len;
  nodeModulesBin = path.join(dir, "node_modules", ".bin");
  scripts = getNodeModulesScripts(nodeModulesBin);
  for (_i = 0, _len = scripts.length; _i < _len; _i++) {
    script = scripts[_i];
    sanitizedName = sanitizeFunctionName(script);
    global[script] = invokeNodeModuleScript(nodeModulesBin, script);
    global[sanitizedName] = global[script];
  }
};

getNodeModulesScripts = function(dir) {
  var name, result, script, scripts, _i, _len;
  if (!test("-d", dir)) {
    return [];
  }
  result = {};
  scripts = ls(dir);
  for (_i = 0, _len = scripts.length; _i < _len; _i++) {
    script = scripts[_i];
    name = script.split(".")[0];
    result[name] = name;
  }
  return _.keys(result);
};

invokeNodeModuleScript = function(scriptPath, script) {
  if (process.platform === "win32") {
    script = script + ".cmd";
  }
  return function() {
    var command, commandArgs, execArgs;
    commandArgs = arguments[0], execArgs = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    command = (path.join(scriptPath, script)) + " " + commandArgs;
    execArgs.unshift(command);
    exec.apply(null, execArgs);
  };
};

sanitizeFunctionName = function(scriptName) {
  return scriptName.replace(/[^\d\w_$]/g, "_");
};

log = function(message) {
  if ((message == null) || message === "") {
    console.log("");
  } else {
    console.log(pkg.name + ": " + message);
  }
};

main();

//# sourceMappingURL=cakex.js.map