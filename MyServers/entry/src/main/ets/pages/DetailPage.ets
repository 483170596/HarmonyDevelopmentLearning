import router from '@ohos.router'
import { Process, ServerData } from '../common/bean/ServerData'
import CommonConstants from '../common/constants/CommonConstants'
import { getProcess, loadServerInfo } from '../common/utils/DataUtil'

@Entry
@Component
struct DetailPage {
  private address: string = router.getParams()['address']
  private name: string = router.getParams()['name']
  @State server: ServerData = new ServerData()
  @State process: Process = new Process()

  aboutToAppear() {
    loadServerInfo(this.address, (result) => {
      this.server = result
    })
    getProcess(this.address, (result) => {
      this.process = result
    })
  }

  @Styles borders() {
    .margin(5)
    .border({ width: 1, color: $r('app.color.Avocado_Green'), radius: 16 })
    .backgroundColor($r('app.color.white'))
  }

  build() {
    Navigation() {
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Row() {
          Image($r('app.media.cpu'))
            .width(80)
            .height(80)
            .margin(10)

          Stack() {
            DataPanel({ values: [0, 0, 0, 0, 0, 0, this.server.cpu], max: 100, type: DataPanelType.Circle })
              .width(168)
              .height(168)

            Row() {
              Text(this.server.cpu.toString())
                .fontSize(30)
                .fontColor('#182431')
              Text('%')
                .fontSize(10)
                .lineHeight(12.83)
                .fontWeight(500)
                .opacity(0.6)
            }
          }

          // Divider().vertical(true).height(168)

        }
        .width('95%')
        .borders()

        Row() {
          Image($r('app.media.memory'))
            .width(60)
            .height(60)
            .margin(10)

          Column() {
            Text('内存').fontSize(20)
            Text(this.server.mem + '%')
            DataPanel({ values: [0, 0, 0, 0, 0, 0,this.server.mem], max: 100, type: DataPanelType.Line })
              .width('73%')
              .borders()
              .height(20)
              .backgroundColor($r('app.color.gray'))
          }
        }
        .height(100)
        .width('95%')
        .borders()

        Row() {
          Image($r('app.media.vmemory'))
            .width(50)
            .height(50)
            .margin(10)
          Column() {
            Text('交换区')
              .fontSize(20)
            Text(this.server.swap + '%')
            DataPanel({ values: [0, 0, 0, 0, 0, 0,this.server.swap], max: 100, type: DataPanelType.Line })
              .width('70%')
              .height(20)
              .borders()
              .backgroundColor($r('app.color.gray'))
          }
        }
        .height(100)
        .width('95%')
        .borders()

        Row() {
          Text('CPU')
            .fontSize(30)
            .margin({ left: 10 })

          Column() {
            Text(this.server.cpu_name)
              .fontSize(12)
              .lineHeight(30)
            Text((this.server.cpu_hz_current / 1000000000).toFixed(2) + ' / ' + (this.server.cpu_hz / 1000000000).toFixed(2) + 'GHz')
              .lineHeight(30)

          }
          .margin({ left: 20 })
          .padding({ left: 15, right: 5 })
        }
        .height(100)
        .width('95%')
        .borders()

        Row() {
          Column() {
            Image($r('app.media.process'))
              .width(50)
              .height(50)
              .margin({ left: 20, top: 15, right: 10 })
            Text('进程').fontSize(22)
          }
          .margin({ left: 10 })

          Column({ space: 15 }) {
            Text('Pid_max: ' + this.process.pid_max)
            Text('Running: ' + this.process.running)
            Text('Sleeping: ' + this.process.sleeping)
            Text('Thread: ' + this.process.thread)
            Text('Total: ' + this.process.total)
          }
          .padding({ left: 50 })
          .margin({ top: 20, bottom: 20 })
          .width('50%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('95%')
        .borders()

        // Column() {
        //   Row() {
        //     Image($r('app.media.process'))
        //       .width(50)
        //       .height(50)
        //       .margin({ left: 20, top: 15, right: 10 })
        //     Text('Process').fontSize(22)
        //   }
        //   .width(CommonConstants.FULL)
        //
        //   Column({ space: 15 }) {
        //     Text('Pid_max: ' + this.process.pid_max)
        //     Text('Running: ' + this.process.running)
        //     Text('Sleeping: ' + this.process.sleeping)
        //     Text('Thread: ' + this.process.thread)
        //     Text('Total: ' + this.process.total)
        //   }
        //   .padding({ left: 50 })
        //   .width('50%')
        //   .alignItems(HorizontalAlign.Start)
        // }
        // .width('95%')
        // .margin(10)
        // .borders()

      }
      .width(CommonConstants.FULL)
      .height(CommonConstants.FULL)
      .backgroundColor($r('app.color.gray'))
    }
    .title(`${this.name}`)
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}