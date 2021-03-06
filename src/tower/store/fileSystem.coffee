File = require('pathfinder').File

class Tower.Store.FileSystem extends Tower.Store
  # add load paths if you need to, e.g.
  # Tower.View.store().loadPaths.push("themes/views")
  constructor: (loadPaths = []) ->
    @loadPaths = loadPaths
    @records   = {}
    
  findPath: (query, callback) ->
    path          = query.path
    ext           = query.ext || ""
    prefixes      = query.prefixes || []
    loadPaths     = @loadPaths
    patterns      = []
    
    if typeof(path) == "string"
      for loadPath in loadPaths
        for prefix in prefixes
          patterns.push new RegExp("#{loadPath}/#{prefix}/#{path}\\.#{ext}", "i")
        patterns.push new RegExp("#{loadPath}/#{path}\\.#{ext}", "i")
    else
      patterns.push path
    
    templatePaths = File.files.apply(File, loadPaths)
    
    for templatePath in templatePaths
      for pattern in patterns
        if !!templatePath.match(pattern)
          callback(null, templatePath) if callback
          return templatePath
    
    callback(null, null) if callback
    null
    
  find: (query, callback) ->
    path = @findPath query
    return (File.read(path) || "") if path
    null
    
  @alias "select", "find"
  
  first: (query, callback) ->
  
  last: (query, callback) ->
  
  all: (query, callback) ->
  
  length: (query, callback) ->
    
  @alias "count", "length"
    
  remove: (query, callback) ->
    
  clear: ->
    
  toArray: ->
    
  create: (record, callback) ->
    @collection().insert(record, callback)
    
  update: (record) ->
    
  destroy: (record) ->
    
  sort: ->
  
module.exports = Tower.Store.FileSystem
