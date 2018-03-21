var BaseApi = requireLib('./lib/api/common/base_api');

class ScheduleApi extends BaseApi {

    constructor(pool, enableLogging) {
        super(pool, enableLogging);
        this._maxResponseItems = 100;
    }

    scheduleGet(req, res, next) {
        const params = this._readScheduleParams(req.query);
        this._executeSqlAndRespond('schedule.sql', params, res);
    }

    _readScheduleParams(query) {
        var page = query.page ? Math.max(this._readQueryNumber(query.page), 0) : 0;
        var pageSize = query.pageSize ? Math.min(Math.max(this._readQueryNumber(query.pageSize), 0), this._maxResponseItems) : 0;
        
        return [
            this._readQueryFilter(query.faculty, true),
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
}

module.exports = ScheduleApi;