export default class MetricInfo {
  id: number;
  serverId: number;
  time: string;
  cpuUsage: string;
  memoryUsage: string;
  diskUsage: string;
  networkIn: string;
  networkOut: string;
  status: number;

  constructor(id: number, serverId: number, time: string, cpuUsage: string, memoryUsage: string, diskUsage: string, networkIn: string, networkOut: string, status: number) {
    this.id = id;
    this.serverId = serverId;
    this.time = time;
    this.cpuUsage = cpuUsage;
    this.memoryUsage = memoryUsage;
    this.diskUsage = diskUsage;
    this.networkIn = networkIn;
    this.networkOut = networkOut;
    this.status = status;
  }
}