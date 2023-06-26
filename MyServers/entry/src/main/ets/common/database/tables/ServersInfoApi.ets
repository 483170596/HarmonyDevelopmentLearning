import dataRdb from '@ohos.data.relationalStore';
import ServersInfo from '../../bean/ServersInfo';
import { SERVERS_INFO } from '../../constants/CommonConstants'
import RdbUtils from '../Rdb/RdbUtils';
import Logger from '../../utils/Logger';

class ServersInfoApi {
  /**
   * insert serversInfo
   *
   * @param serversInfo
   * @param callback
   */
  insertData(serversInfo: ServersInfo, callback): void {
    const valueBucket = generateBucket(serversInfo);
    RdbUtils.insert('serversInfo', valueBucket).then(result => {
      callback(result);
    });
    Logger.info('ServersInfoTable', `Insert serversInfo {${serversInfo.id}:${serversInfo.name}} finished.`);
  }
  /**
   * delete serversInfo
   *
   * @param serversInfo
   * @param callback
   */
  deleteDataByID(serversInfo: ServersInfo, callback): void {
    let predicates = new dataRdb.RdbPredicates(SERVERS_INFO.tableName);
    // 根据id匹配要删除的数据
    predicates.equalTo('id', serversInfo.id);
    RdbUtils.del(predicates).then(result => {
      callback(result);
    });
    Logger.info('ServersInfoTable', `Delete serversInfo {${serversInfo.id}:${serversInfo.name}} finished.`);
  }
  /**
   * query serversInfo
   *
   * @param serversInfo
   * @param callback
   */
  query(id: number, callback): void {
    let predicates = new dataRdb.RdbPredicates(SERVERS_INFO.tableName);
    predicates.equalTo('id', id);
    RdbUtils.query(predicates).then(resultSet => {
      let count = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        Logger.error('TaskInfoTable', `${id} query no results!`);
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result = [];
        for (let i = 0; i < count; i++) {
          let tmp = new ServersInfo(0, '', '', '', '', '', '',);
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.name = resultSet.getString(resultSet.getColumnIndex('name'));
          tmp.ip = resultSet.getString(resultSet.getColumnIndex('ip'));
          tmp.os = resultSet.getString(resultSet.getColumnIndex('os'));
          tmp.cpu = resultSet.getString(resultSet.getColumnIndex('cpu'));
          tmp.memory = resultSet.getString(resultSet.getColumnIndex('memory'));
          tmp.disk = resultSet.getString(resultSet.getColumnIndex('disk'));
          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }
}

function generateBucket(serversInfo: ServersInfo): dataRdb.ValuesBucket {
  let valueBucket = {};
  SERVERS_INFO.columns.forEach((item: string) => {
    if (item !== 'id') {
      valueBucket[item] = serversInfo[item];
    }
  });
  return valueBucket;
}

let taskInfoApi = new ServersInfoApi();

export default taskInfoApi as ServersInfoApi;
