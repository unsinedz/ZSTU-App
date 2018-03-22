const express = require('express');
const app = express();
const router = express.Router();

const sql = require('mysql');
const dbConfig = require('config').get('dbConfig');

const ScheduleApi = require('./api/schedule');
const FacultyApi = require('./api/faculty');
const Index = require('./');

class Server {

    constructor(hostname, port, enableLogging) {
        this.hostname = hostname;
        this.port = +port;
        this.enableLogging = !!enableLogging;
    }

    start() {
        try {
            this.pool = sql.createPool(dbConfig);
        }
        catch (e) {
            print('SQL database is not available.');
            return;
        }

        var scheduleApi = new ScheduleApi(this.pool, true);
        var facultyApi = new FacultyApi(this.pool, true);
        var index = new Index();

        const _makeResponse = this._makeResponse;

        router.get('/group', (req, res, next) =>
            facultyApi.groupGet(req, next).then(result => res.send(_makeResponse(null, result)))
                .catch(err => res.send(_makeResponse(err)))
        );
        router.get('/faculty', (req, res, next) =>
            facultyApi.facultyGet(req, next).then(result => res.send(_makeResponse(null, result)))
                .catch(err => res.send(_makeResponse(err)))
        );
        router.get('/timetable', (req, res, next) =>
            facultyApi.timetableGet(req, next).then(result => res.send(_makeResponse(null, result)))
                .catch(err => res.send(_makeResponse(err)))
        );
        router.get('/schedule', (req, res, next) =>
            scheduleApi.scheduleGet(req, next).then(result => res.send(_makeResponse(null, result)))
                .catch(err => res.send(_makeResponse(err)))
        );
        router.get('/', (req, res, next) =>
            index.indexGet(req, next).then(result => res.send(result))
                .catch(err => res.send('An error occurred'))
        );

        app.use('/', router);
        app.listen(this.port, this.hostname);

        if (this.enableLogging)
            console.log(`[PID ${process.pid}] Started server listening on port ${this.port}`);
    }

    _wrapHandler(req, res, next, handler) {
        handler(req, res, next).then(result => res.send(_makeResponse(null, result)))
            .catch(err => res.send(_makeResponse(err)));
    }

    _makeResponse(err, data, htmlNewlines) {
        var resObj = {};
        if (err) {
            if (this.enableLogging) console.error(err);
            resObj = {
                "count": 0,
                "error": 'An error occurred.'
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
}

module.exports = Server;