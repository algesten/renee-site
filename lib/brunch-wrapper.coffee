module.exports = startServer: ({port, path}, cb) ->
    GLOBAL.BRUNCH_PORT = port
    GLOBAL.BRUNCH_PATH = path
    require './web'
    cb()
