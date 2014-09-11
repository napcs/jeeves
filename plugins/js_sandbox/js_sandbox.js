#! /usr/bin/env node
var Sandbox = require("sandbox");
var userArgs = process.argv.slice(2);
var codeToExec = userArgs[0];

if(codeToExec){
  var s = new Sandbox();
  s.run(codeToExec, function(output) {
    out = "";
    if(output.result !== "null"){
      out += output.result;
    }
    out += output.console.join("\n");
    console.log(out);
  });
}else{
  console.log("Please provide some code.");
}

