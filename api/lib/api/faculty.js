var BaseApi = require('./common/base_api');

class FacultyApi extends BaseApi {

    constructor(pool, enableLogging) {
        super(pool, enableLogging);
        this._maxResponseItems = 100;
    }

    facultyGet(req, next) {
        const params = this._readFacultyParams(req.query);
        return this._executeSqlAndRespond('faculty.sql', params);
    }

    _readFacultyParams(query) {
        var page = query.page ? Math.max(this._readQueryNumber(query.page), 0) : 0;
        var pageSize = query.pageSize ? Math.min(Math.max(this._readQueryNumber(query.pageSize), 0), this._maxResponseItems) : 0;

        return [
            page * pageSize,
            pageSize
        ];
    }

    groupGet(req, next) {
        const params = this._readGroupParams(req.query);
        return this._executeSqlAndRespond('group.sql', params);
    }

    _readGroupParams(query) {
        var page = query.page ? Math.max(this._readQueryNumber(query.page), 0) : 0;
        var pageSize = query.pageSize ? Math.min(Math.max(this._readQueryNumber(query.pageSize), 0), this._maxResponseItems) : 0;

        return [
            query.faculty || '',
            query.year || '',
            page * pageSize,
            pageSize
        ];
    }

    timetableGet(req, next) {
        const params = this._readTimetableParams(req.query);
        return this._executeSqlAndRespond('timetable.sql', params);
    }

    _readTimetableParams(query) {
        var page = query.page ? Math.max(this._readQueryNumber(query.page), 0) : 0;
        var pageSize = query.pageSize ? Math.min(Math.max(this._readQueryNumber(query.pageSize), 0), this._maxResponseItems) : 0;

        return [
            page * pageSize,
            pageSize
        ];
    }
}

module.exports = FacultyApi;