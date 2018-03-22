const appSettings = require('config').get('app');
const cluster = require('cluster');

const cores = require('os').cpus().length;
const Runtime = require('./lib/runtime');

const Server = require('./lib/server');

if (cluster.isWorker) {
    cluster.worker.on('message', message => {
        if (message && message.cmd === 'startServer')
            startServer(message.hostname, message.port);
    });
    return;
}

if (appSettings.enableLogging) {
    console.log('---------------------------------------------');
    console.log(`[PID ${process.pid}] Starting master`);
    console.log('---------------------------------------------');
}

if (!appSettings.runInstancePerCore) {
    startServer(appSettings.hostname, appSettings.port);
    return;
}

new Runtime(cluster, cores, appSettings.renewWorkers, appSettings.enableLogging).clusterize();

var port = +appSettings.port;
const hostname = appSettings.hostname;
for (const id in cluster.workers) {
    const startingPort = port++;
    cluster.workers[id].send({ cmd: 'startServer', hostname: hostname, port: startingPort });
}

function startServer(hostname, port) {
    const server = new Server(hostname, port, appSettings.enableLogging);
    server.start();
}