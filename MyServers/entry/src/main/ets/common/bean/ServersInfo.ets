export default class ServerInfo {
  id : number;
  name: string;
  ip: string;
  os : string;
  cpu : string;
  memory : string;
  disk : string;

  constructor(id : number,name: string,ip: string,os : string,cpu : string,memory : string,disk : string) {
    this.id = id;
    this.name = name;
    this.ip = ip;
    this.os = os;
    this.cpu = cpu;
    this.memory = memory;
    this.disk = disk;
  }
}