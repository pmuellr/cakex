var path = require("path")

var program = path.basename(__filename)
var index   = process.argv[2] || "0"
var wait    = process.argv[3] || "6000"

index = parseInt(index, 10)
wait  = parseInt(wait,  10)

log("starting")
setTimeout(onDone, wait)

var interval = setInterval(onInterval,  500)

//-------------------------------------
function onDone() {
  log("done")
  clearInterval(interval)
}

//-------------------------------------
function onInterval() {
  log("waiting")
}

//-------------------------------------
function log(message) {
  var time = new Date().toISOString().slice(14,22)
  console.log(program + ": " + index + ": " + time + ": " + message)
}
