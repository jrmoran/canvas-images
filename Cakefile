# Cakefile to document, compile, join and minify CoffeeScript files for
# client side apps. Just edit the config object literal.
#
# -jrmoran

fs            = require 'fs'
{exec, spawn} = require 'child_process'

# order of files in `inFiles` is important
config =
  srcDir:  'coffee'
  outDir:  'js'
  inFiles: [ 'color', 'imageCanvas', 'dropzone', 'toolbar', 'app' ]
  outFile: 'client'
  yuic:    '~/Dropbox/toolbox/dotfiles/bin/yuicompressor-2.4.2.jar'

outJS    = "#{config.outDir}/#{config.outFile}"
strFiles = ("#{config.srcDir}/#{file}.coffee" for file in config.inFiles).join ' '

# deal with errors from child processes
exerr  = (err, sout,  serr)->
  console.log err if err
  console.log sout if sout
  console.log serr if serr

task 'doc', 'generate documentation for *.coffee files', ->
  exec "docco #{config.srcDir}/*.coffee", exerr

# this will keep the non-minified compiled and joined file updated as files in
# `inFile` change.
task 'watch', 'watch and compile changes in source dir', ->
  watch = exec "coffee -j #{outJS}.js -cw #{strFiles}"
  watch.stdout.on 'data', (data)-> console.log data

task 'build', 'join and compile *.coffee files', ->
  exec "coffee -j #{outJS}.js -c #{strFiles}", exerr

task 'min', 'minify compiled *.js file', ->
  exec "java -jar #{config.yuic} #{outJS}.js -o #{outJS}.min.js", exerr

task 'bam', 'build and minify', ->
  invoke 'build'
  invoke 'min'
