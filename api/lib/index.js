const appConfig = require('config').get('app');

class Index {

    indexGet(req, res, next) {
        res.send(`ZSTU API v${appConfig.version || 0}`);
    }
}

module.exports = Index;