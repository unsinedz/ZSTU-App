const appConfig = require('config').get('app');

class Index {

    indexGet(req, next) {
        return new Promise((res, rej) => res(`ZSTU API v${appConfig.version || 0}`));
    }
}

module.exports = Index;