logger = require('../index')('./logs')
console.log logger

logger.info 'hello'
logger.createNewLogger('new').info 'new Logger'
logger.createNewLogger('new').info 'new Logger'

