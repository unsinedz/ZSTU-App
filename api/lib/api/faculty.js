var BaseApi = requireLib('./lib/api/common/base_api');

class FacultyApi extends BaseApi {

    constructor(pool, enableLogging) {
        super(pool, enableLogging);
        this._maxResponseItems = 100;
    }

    facultyGet(req, res, next) {
        const params = this._readFacultyParams(req.query);
        this._executeSqlAndRespond('faculty.sql', params, res);
    }

    _readFacultyParams(query) {
        var page = query.page ? Math.max(this._readQueryNumber(query.page), 0) : 0;
        var pageSize = query.pageSize ? Math.min(Math.max(this._readQueryNumber(query.pageSize), 0), this._maxResponseItems) : 0;

        return [
            page * pageSize,
            pageSize
        ];
    }

    groupGet(req, res, next) {
        const params = this._readGroupParams(req.query);
        this._executeSqlAndRespond('group.sql', params, res);
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

    timetableGet(req, res, next) {
        const params = this._readTimetableParams(req.query);
        this._executeSqlAndRespond('timetable.sql', params, res);
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