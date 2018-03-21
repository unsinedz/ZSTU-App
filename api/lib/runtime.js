class Runtime {

    constructor(cluster, workersCount, renewWorkers, enableLogging) {
        this.cluster = cluster;
        this.workersCount = +workersCount;
        this.renewWorkers = !!renewWorkers;
        this.enableLogging = !!enableLogging;
    }

    clusterize() {
        var self = this;
        for (var i = 0; i < self.workersCount; i++) {
            var worker = self.cluster.fork();

            if (self.enableLogging)
                console.log(`[PID ${worker.process.pid}] Starting worker`);
        }

        if (self.renewWorkers) {
            var renewer = (worker) => {
                if (self.enableLogging)
                    console.log(`[PID ${worker.process.pid}] Killing worker`);

				if (self.cluster.isWorker) {
					var newOne = self.cluster.fork();

					if (self.enableLogging)
						console.log(`[PID ${newOne.process.pid}] Starting worker`);
				}
            };
            self.cluster.on('exit', renewer);
            self.cluster.on('error', renewer);
        }
    }
}

module.exports = Runtime;