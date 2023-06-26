import ItemData from '../common/bean/ItemData';
import { Address } from '../common/bean/ServerData'

export class MainViewModel{
  /**
   * Get data of the setting list.
   *
   * @return {Array<PageResource>} settingListData.
   */
  getSettingListData(): Array<ItemData> {
    let settingListData: ItemData[] = [
      new ItemData($r('app.string.setting_list_news'), $r("app.media.news"), $r("app.string.setting_toggle")),
      new ItemData($r('app.string.setting_list_data'), $r("app.media.data"), null),
      new ItemData($r('app.string.setting_list_menu'), $r("app.media.menu"), null),
      new ItemData($r('app.string.setting_list_about'), $r("app.media.about"), null),
      new ItemData($r('app.string.setting_list_storage'), $r("app.media.storage"), null),
      new ItemData($r('app.string.setting_list_privacy'), $r("app.media.privacy"), null)
    ];
    return settingListData;
  }

  //标记-----------
  getServerList(): Address[] {
    return [
      {
        name: '服务器测试',
        address: null,
        port: null,
        connected: false
      },
      {
        name: '服务器2',
        address: null,
        port: null,
        connected: false
      },
      {
        name: '服务器3',
        address: null,
        port: null,
        connected: true
      }
    ]
  }

}

export default new MainViewModel();