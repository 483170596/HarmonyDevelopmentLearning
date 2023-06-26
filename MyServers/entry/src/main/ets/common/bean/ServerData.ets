export class ServerData {

  cpu: number = 0;

  cpu_hz: number = 0;

  cpu_hz_current: number = 0;

  cpu_name: string = null;

  mem: number = 0;

  swap: number = 0;

  // constructor(cpu, cpu_hz, cpu_hz_current, cpu_name, mem, swap) {
  //   this.cpu = cpu
  //   this.cpu_hz = cpu_hz
  //   this.cpu_hz_current = cpu_hz_current
  //   this.cpu_name = cpu_name
  //   this.mem = mem
  //   this.swap = swap
  // }
}

export class Process {

  pid_max: number = 0;

  running: number = 0;

  sleeping: number = 0;

  thread: number = 0;

  total: number = 0;

  // constructor(pid_max, running, sleeping, thread, total) {
  //   this.pid_max = pid_max
  //   this.running = running
  //   this.sleeping =sleeping
  //   this.thread = thread
  //   this.total = total
  // }
}

export class Address {

  name: string = null ;

  address: string = '127.0.0.1';

  port: number = 61208;

  connected: boolean = false;

  // constructor(name, address, port, connected) {
  //   this.name = name
  //   this.address = address
  //   this.port = port
  //   this.connected = connected
  // }
}