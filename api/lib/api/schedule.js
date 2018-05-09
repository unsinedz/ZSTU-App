var BaseApi = require('./common/base_api');

class ScheduleApi extends BaseApi {

    constructor(pool, enableLogging) {
        super(pool, enableLogging);
        this._maxResponseItems = 100;
    }

    scheduleGet(req, next) {
        const params = this._readScheduleParams(req.query);
        return this._executeSqlAndRespond('schedule.sql', params);
    }

    _readScheduleParams(query) {
        var page = query.page ? Math.max(this._readQueryNumber(query.page), 0) : 0;
        var pageSize = query.pageSize ? Math.min(Math.max(this._readQueryNumber(query.pageSize), 0), this._maxResponseItems) : 0;
        
        return [
            this._readQueryFilter(query.faculty),
            this._readQueryFilter(query.group, true),
            this._readQueryFilter(query.week, false, true),
            this._readQueryFilter(query.teacher),
            this._readQueryFilter(query.pairType),
            this._readQueryFilter(query.room),
            this._readQueryFilter(query.time),
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

module.exports = ScheduleApi;