express = require 'express'
slashes = require 'connect-slashes'
http    = require 'http'
sysPath = require 'path'
fs      = require 'fs'

path = GLOBAL.BRUNCH_PATH || 'public'
port = process.env.PORT || GLOBAL.BRUNCH_PORT || 3333

app = express()
dir = sysPath.normalize __dirname + '/../' + path

app.enable 'strict routing'
app.enable 'case sensitive routing'

# headers galore
app.use (req, resp, next) ->
#    resp.header 'Cache-Control', 'no-cache'
#    resp.header 'Access-Control-Allow-Origin', '*'
    next()

# remove trailing slashes
app.use slashes(false)

app.all '/*', (req, resp) ->

    p = req.path

    patterns = [
        "#{p}",
        "#{p}/index.html",
        "#{p}.html"
        ]

    for t in patterns
        trypath = sysPath.normalize (dir + t)
        return res.status '400' if trypath.indexOf('..') == 0
        try
            return resp.sendFile trypath if (fs.lstatSync trypath).isFile()
        catch err
            if err.code != 'ENOENT'
                console.error err
                return reps.status '500'

    resp.status(404).send 'Not found: ' + req.path

server = http.createServer app
console.log 'Listening to:', port
server.listen port
