// Generated by CoffeeScript 1.10.0
var Gaze, _, cakex, countWatched, fs, getTime, path;

fs = require("fs");

path = require("path");

_ = require("underscore");

Gaze = require("gaze").Gaze;

cakex = require("./cakex");

exports.watch = function(watchObject) {
  var files, fired, gaze, run;
  files = watchObject.files, run = watchObject.run;
  gaze = new Gaze(files);
  cakex.log("watching " + (countWatched(gaze.relative())) + " files for changes ...");
  fired = false;
  return gaze.on("all", function(event, file) {
    var err, error;
    if (fired) {
      return;
    }
    fired = true;
    if (file != null) {
      cakex.log("----------------------------------------------------");
      file = path.relative(process.cwd(), file);
      cakex.log("file changed: " + file + " on " + (getTime()));
    }
    try {
      run.apply(watchObject, [file]);
    } catch (error) {
      err = error;
      cakex.log("error running watch function: " + err);
      cakex.log(err.stack);
    }
    gaze.close();
    return exports.watch({
      files: files,
      run: run
    });
  });
};

countWatched = function(rFiles) {
  var count, dir, files;
  count = 0;
  for (dir in rFiles) {
    files = rFiles[dir];
    count += files.length;
  }
  return count;
};

getTime = function() {
  return new Date().toLocaleTimeString();
};

//# sourceMappingURL=watch.js.map
