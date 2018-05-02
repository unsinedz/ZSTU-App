var fs = require('fs');

class BaseApi {

    constructor(pool, enableLogging) {
        this.pool = pool;
        this.enableLogging = !!enableLogging;
    }

    _readQueryNumber(str, defaultValue) {
        try {
            return parseInt(str);
        }
        catch (e) {
            return defaultValue || 0;
        }
    }

    _readQueryFilter(str, required, matchEnd) {
        var result = '';
        if (str) result = str.toString();

        return required ? result : matchEnd ? ('%' + result) : (result + '%');
    }

    _getConnectionFromPool() {
        return new Promise((res, rej) => {
            this.pool.getConnection(function (err, connection) {
                if (err) {
                    rej(err);
                } else {
                    res(connection);
                }
            });
        });
    }

    _readSqlFile(sqlName) {
        return new Promise((res, rej) => {
            fs.readFile(`./lib/api/queries/${sqlName}`, 'utf8', (err, data) => {
                if (err) {
                    rej(err);
                } else {
                    res(data);
                }
            });
        });
    }

    async _executeSqlAndRespond(sqlName, params) {
        if (!sqlName)
            throw new Error('SQL name is undefined')

        const sqlQuery = await this._readSqlFile(sqlName);
        const connection = await this._getConnectionFromPool();
        return new Promise((res, rej) => connection.query(sqlQuery, params, (err, result, fields) => {
            connection.release();
            if (err) {
                rej(err);
            } else {
                res(result);
            }
        }));
    }
}

module.exports = BaseApi;