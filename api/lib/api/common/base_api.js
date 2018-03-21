var fs = require('fs');

class BaseApi {

    constructor(pool, enableLogging) {
        this.pool = pool;
        this.enableLogging = !!enableLogging;
    }

    _handleError(err, res) {
        if (this.enableLogging) console.log(err);
        res.send(this._makeResponse('An error occurred.'));
    }

    _makeResponse(err, data, htmlNewlines) {
        var resObj = {};
        if (err) {
            resObj = {
                "count": 0,
                "error": err
            };
        }
        else if (data) {
            resObj = {
                "count": data.length,
                "items": data
            };
        }

        var str = JSON.stringify(resObj);
        return htmlNewlines ? str.replace(/([,\{])/gi, '$1<br/>').replace(/(\})/gi, '<br/>$1') : str;
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

    _executeSqlAndRespond(sqlName, params, res) {
        if (!sqlName) {
            this._handleError('error');
            return;
        }

        const self = this;
        const response = res;
        fs.readFile(`./lib/api/queries/${sqlName}`, 'utf8', function (err, data) {
            if (err) {
                self._handleError(err, response);
                return;
            }

            self.pool.getConnection(function (err, connection) {
                if (err) {
                    self._handleError(err, response);
                    return;
                }

                connection.query(data, params, (err, res, fileds) => {
                    if (err) {
                        self._handleError(err, response);
                        return;
                    }

                    connection.release();
                    response.send(self._makeResponse(null, res));
                });
            });
        });
    }
}

module.exports = BaseApi;