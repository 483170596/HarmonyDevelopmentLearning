import hilog from '@ohos.hilog';
import CommonConstants from '../constants/CommonConstants';
import { GetStatus, HttpGet } from '../utils/HttpUtil';

export async function loadServerInfo(address: any, callback, port: number = 61208) {
  let url = `http://${address}:${port}/api/3/quicklook`
  let result = await HttpGet(url)
  if (result) {
    callback(result)
  }
}

export async function getProcess(address: any, callback, port: number = 61208) {
  let url = `http://${address}:${port}/api/3/processcount`
  let result = await HttpGet(url)
  if (result) {
    callback(result)
  }
}

export async function getStatus(address: any, callback, port: number = 61208) {
  let url = `http://${address}:${port}/api/3/status`

  if (await GetStatus(url) == CommonConstants.HTTP_CODE_200) {
    callback(true)
    hilog.info(0x0000,'test','Success')
  }else callback(false)
}
