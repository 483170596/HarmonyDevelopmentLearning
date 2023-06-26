import { Address } from '../common/bean/ServerData'
import { FULL_WIDTH } from '../common/constants/CommonConstants'
import CommonConstants from '../common/constants/CommonConstants'
import MainViewModel from '../viewmodel/MainViewModel'
import { getStatus} from '../common/utils/DataUtil'
import { Dialog } from './Dialog'

@Component
export default struct Home {
  @State @Watch('changelist') arr: Address[] = []
  @State delList: any[] = []
  @State status: boolean[] = []

  @State isRefreshing: Boolean = false

  @State arrTest: Address[] = MainViewModel.getServerList()
  @State addIcon: string = CommonConstants.addIcon_norm
  @State delIcon: string = CommonConstants.delIcon_norm
  @State editIcon: string = CommonConstants.editIcon_norm

  @State Search: Visibility = Visibility.None
  @State ShowMenu: Visibility = Visibility.None

  dialogController: CustomDialogController = new CustomDialogController({
    builder: Dialog({ arr: $arr}),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  });

  changelist() {
    if (this.arr) {
      this.arr.forEach((each,index) => {
        getStatus(each.address, (status) => {
          this.status[index] = status
        })
      })
    }
  }

  @Builder menu() {
    Row() {
      Image(this.addIcon)
        .width(CommonConstants.Icon_Size)
        .height(CommonConstants.Icon_Size)
        .margin({ right: 24 })
        .visibility(this.ShowMenu ? Visibility.Visible : Visibility.None)
        .onTouch((event: TouchEvent) => {
          this.addIcon = (event.type === TouchType.Down) ?
          CommonConstants.addIcon_pressed : CommonConstants.addIcon_norm
        })
        .onClick(() => {
          this.dialogController.open();
        })

      Image(this.delIcon)
        .width(CommonConstants.Icon_Size)
        .height(CommonConstants.Icon_Size)
        .margin({ right: 24 })
        .visibility(this.ShowMenu)
        .onTouch((event: TouchEvent) => {
          this.delIcon = (event.type === TouchType.Down) ?
          CommonConstants.delIcon_pressed : CommonConstants.delIcon_norm
        })
        .onClick(() => {
          this.arr = this.arr.filter((item) => {
            this.delList.indexOf(item) == -1
          })
        })

      Image(this.editIcon)
        .width(CommonConstants.Icon_Size)
        .height(CommonConstants.Icon_Size)
        .onTouch((event: TouchEvent) => {
          this.editIcon = (event.type === TouchType.Down) ?
          CommonConstants.editIcon_pressed : CommonConstants.editIcon_norm
        })
        .onClick(() => {
          this.ShowMenu = this.ShowMenu ? Visibility.Visible : Visibility.None
        })
    }
    .justifyContent(FlexAlign.End)
    .width(FULL_WIDTH)
  }

  build() {
    Navigation() {
      List({ space: 10, initialIndex: 0 }) {
        ListItem() {
          Search({ placeholder: CommonConstants.Search_description })
            .backgroundColor($r('app.color.ghost_white'))
            .width(CommonConstants.Search_width)
        }

        ForEach(this.arr, (item, index) => {
          ListItem() {
            Navigator({ target: 'pages/DetailPage' }) {
              Row() {
                if (index % 3 == 0) {
                  Image($r('app.media.server0'))
                    .width(60)
                    .height(60)
                    .margin({ left: 10 })
                }
                else if (index % 3 == 1) {
                  Image($r('app.media.server1'))
                    .width(60)
                    .height(60)
                    .margin({ left: 10 })
                }
                else {
                  Image($r('app.media.server2'))
                    .width(60)
                    .height(60)
                    .margin({ left: 10 })
                }


                Text(`${item.name}`)
                  .fontSize(18)
                  .textAlign(TextAlign.Center)

                Blank()

                Image(this.status[index] ? $r('app.media.working') : $r('app.media.disconnected'))
                  .width(CommonConstants.Icon_Size)
                  .height(CommonConstants.Icon_Size)
                  .margin(10)
                  .colorBlend($r('app.color.font_gray'))

                Text(this.status[index] ? '状态：在线' : '状态：离线')
                  .margin({ right: 15 })
                  .fontSize(12)
                    // .fontColor($r('app.color.font_gray'))
                  .fontColor(this.status[index] ? $r('app.color.green') : $r('app.color.red'))
                  .textAlign(TextAlign.Center)

                Checkbox()
                  .margin({ right: 15 })
                  .selectedColor($r('app.color.Avocado_Green'))
                  .visibility(this.ShowMenu)
                  .onChange((value) => {
                    if (value) {
                      this.delList.push(this.arr[index])
                    }else {
                      this.delList = this.delList.filter((item)=> item!= this.arr[index])
                    }
                  })
              }
              .justifyContent(FlexAlign.End)
              .width('95%')
              .height(80)
              .backgroundColor($r('app.color.white'))
              .border({ color: $r('app.color.Avocado_Green'), radius: 16, width: 1 })
            }
            .params({address: this.arr[index].address,
              name: this.arr[index].name})
          }
        }, item => item)

        ForEach(this.arrTest, (item, index) => {
          ListItem() {
            Navigator({ target: 'pages/DetailPage' }){
              Row() {
                if (index % 3 == 0) {
                  Image($r('app.media.server0'))
                    .width(60)
                    .height(60)
                    .margin({ left: 10 })
                }
                else if (index % 3 == 1) {
                  Image($r('app.media.server1'))
                    .width(60)
                    .height(60)
                    .margin({ left: 10 })
                }
                else {
                  Image($r('app.media.server2'))
                    .width(60)
                    .height(60)
                    .margin({ left: 10 })
                }

                Text(`${item.name}`)
                  .fontSize(18)
                  .textAlign(TextAlign.Center)

                Blank()

                Image(item.connected? $r('app.media.working') : $r('app.media.disconnected'))
                  .width(CommonConstants.Icon_Size)
                  .height(CommonConstants.Icon_Size)
                  .margin(10)
                  .colorBlend($r('app.color.font_gray'))

                Text(item.connected? '状态：在线': '状态：离线')
                  .margin({right: 15})
                  .fontSize(12)
                    // .fontColor($r('app.color.font_gray'))
                  .fontColor(item.connected? $r('app.color.green'): $r('app.color.red'))
                  .textAlign(TextAlign.Center)

                Checkbox()
                  .margin({right: 15})
                  .selectedColor($r('app.color.Avocado_Green'))
                  .visibility(this.ShowMenu)
                  .onChange(() => {
                    //todo
                  })
              }
              .justifyContent(FlexAlign.End)
              .width('95%')
              .height(80)
              .backgroundColor($r('app.color.white'))
              .border({ color: $r('app.color.Avocado_Green'), radius: 16, width: 1})

            }
          }
        }, item => item)
      }
      .backgroundColor($r('app.color.gray'))
      .listDirection(Axis.Vertical)
      .height(CommonConstants.FULL)
      .width(CommonConstants.FULL)
      .alignListItem(ListItemAlign.Center)
      .editMode(true)
      .borderRadius(15)
    }
    .title(CommonConstants.Server_List)
    .titleMode(NavigationTitleMode.Free)
    .menus(this.menu)
    .mode(NavigationMode.Auto)
  }
}