import { Address } from '../common/bean/ServerData'
import Logger from '../common/utils/Logger'

@CustomDialog
export  struct Dialog {
  @Link arr: Address[]
  @State name: string = ''
  @State address: string = ''
  controller: CustomDialogController

  build() {
    Column() {
      Text('添加服务器').fontSize(20).margin({ top: 10, bottom: 10 })
      Row() {
        Text('名称').fontSize(16).margin({ left: 20 }).width('20%')
        TextInput({ placeholder: '', text: this.name })
          .height(60).width('75%')
          .onChange((value: string) => {
            this.name = value
          })
      }
      .width('100%')
      .margin({ bottom: 10})

      Row() {
        Text('地址').fontSize(16).margin({ left: 20 }).width('20%')
        TextInput({ placeholder: '', text: this.address })
          .height(60).width('75%')
          .onChange((value: string) => {
            this.address = value
          })
      }
      .width('100%')
      .margin({ bottom: 10})

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确认')
          .onClick(() => {
            if (this.name && this.address) {
              let tmp = new Address()
              tmp.name = this.name
              tmp.address = this.address
              this.arr.push(tmp)
            } else {
              Logger.info('dialog confirm error')
            }
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Blue)
      }.margin({ bottom: 10 })
    }
    .backgroundColor($r('app.color.white'))
    .borderRadius(24)
  }
}