fs = require 'fs'
_ = require 'lodash'
winston = require 'winston'

env = process.env.NODE_ENV or 'development'

instanceCache = {}

restmanLogger = (logDirPath) ->
  error = new Error('logDirPath is not exists')
  return error unless logDirPath
  return error unless _.isString logDirPath
  return error unless fs.existsSync logDirPath

  createNewLogger = (logName = 'restman') ->
    if _.has instanceCache, logName
      return instanceCache[logName]
    logger = new winston.Logger
    if env is 'development'
      logger.add winston.transports.Console,
        colorize: true
        timestamp: true
        prettyPrint: true
    else
      logger.add winston.transports.File,
        filename: "#{logDirPath}/#{logName}.log"
    instanceCache[logName] = logger
    logger

  instance = createNewLogger()
  instance.createNewLogger = createNewLogger
  instance

module.exports = restmanLogger
