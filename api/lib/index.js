const appConfig = require('config').get('app');

class Index {

    handleGet(req, res, next) {
        res.send(`ZSTU API v${appConfig.version || 0}`);
    }
}

module.exports = Index;