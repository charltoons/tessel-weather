express         = require 'express'
path            = require 'path'
logger          = require 'morgan'
cookieParser    = require 'cookie-parser'
bodyParser      = require 'body-parser'
debug           = require('debug')('server')

app = express()

# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

# express setup
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use express.static path.join(__dirname, 'public')

router = express.Router()

# GET home page. 
router.get '/', (req, res)->
  res.render 'index'


# add routes
app.use '/', router

# catch 404 and forward to error handler
app.use (req, res, next)->
    err = new Error('Not Found')
    err.status = 404
    next(err)

# development error handler
# will print stacktrace
if app.get('env') is 'development'
    app.use (err, req, res, next)->
        res.status (err.status or 500)
        res.render 'error',
            message: err.message
            error: err

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next)->
    res.status (err.status or 500)
    res.render 'error',
        message: err.message
        error: {}


module.exports = app
