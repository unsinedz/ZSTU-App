var BaseApi = requireLib('./lib/api/common/base_api');

class TeacherApi extends BaseApi {
    
    constructor(pool, enableLogging) {
        super(pool, enableLogging);
        this._maxResponseItems = 100;
    }
}