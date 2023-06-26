import http from '@ohos.net.http';
import hilog from '@ohos.hilog';
import CommonConstants from '../constants/CommonConstants';

export function HttpGet(url: string) {

  let httpRequest = http.createHttp();

  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: CommonConstants.HTTP_READ_TIMEOUT,
    connectTimeout: CommonConstants.HTTP_READ_TIMEOUT
  });

  return responseResult.then((value) => {
    if (value.responseCode === CommonConstants.HTTP_CODE_200) {

      let result = value.result.toString()
      let resultJson = JSON.parse(result);

      if (resultJson.cpu) {
        hilog.info(0x0000,'test','HttpSuccess')
      }
      return resultJson;
    } else {
      //todo
    }
  }).catch(() => {
    return 'error'
  })
}

export function GetStatus(url: string) {

  let httpRequest = http.createHttp();

  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: CommonConstants.HTTP_READ_TIMEOUT,
    connectTimeout: CommonConstants.HTTP_READ_TIMEOUT
  });

  return responseResult.then((value) => {
    if (value.responseCode === CommonConstants.HTTP_CODE_200) {
      hilog.info(0x0000,'test','Status online')
    }
    return CommonConstants.HTTP_CODE_200
  }).catch(() => {
    return 'error'
  })
}