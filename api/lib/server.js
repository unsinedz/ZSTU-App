const express = require('express');
const app = express();
const router = express.Router();

const sql = require('mysql');
const dbConfig = require('config').get('dbConfig');

const ScheduleApi = requireLib('./lib/api/schedule');
const FacultyApi = requireLib('./lib/api/faculty');
const Index = requireLib('./lib/index');

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
        }

        var scheduleApi = new ScheduleApi(this.pool, true);
        var facultyApi = new FacultyApi(this.pool, true);
        var index = new Index();

        router.get('/group', (req, res, next) => facultyApi.groupGet(req, res, next));
        router.get('/faculty', (req, res, next) => facultyApi.facultyGet(req, res, next));
        router.get('/timetable', (req, res, next) => facultyApi.timetableGet(req, res, next));
        router.get('/schedule', (req, res, next) => scheduleApi.scheduleGet(req, res, next));
        router.get('/', (req, res, next) => index.handleGet(req, res, next));

        app.use('/', router);
        app.listen(this.port, this.hostname);

        if (this.enableLogging)
            console.log(`[PID ${process.pid}] Started server listening on port ${this.port}`);
    }
}

module.exports = Server;