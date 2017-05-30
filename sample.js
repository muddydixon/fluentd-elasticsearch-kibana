const debug = require("debug")("sample");
const Logger = require("fluent-logger");

const interval = process.env.INTERVAL || 1000;
const prefix = process.env.PREFIX || "es.sample";
const logger = Logger.createFluentSender(prefix, {
  host: process.env.FLUENT_HOST || "192.168.99.100",
  port: process.env.FLUENT_PORT || 24224,
  timeout: process.env.FLUENT_TIMEOUT || 3.0,
  reconnectInterval: process.env.FLUENT_RECONNECT_INTERVAL || 600000
});


const emitSample = (data)=>{
  data.time = Date.now();
  debug(data);
  logger.emit("trial", data);
}

setInterval(()=>{
  const value = 0|Math.random() * 1000;
  emitSample({value});
}, interval);
