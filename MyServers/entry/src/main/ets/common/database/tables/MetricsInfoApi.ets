import dataRdb from '@ohos.data.relationalStore';
import MetricsInfo from '../../bean/MetricsInfo';
import { METRICS_INFO } from '../../constants/CommonConstants'
import RdbUtils from '../Rdb/RdbUtils';
import Logger from '../../utils/Logger';

class MetricsInfoApi {
  /**
   * insert metricsInfo
   *
   * @param metricsInfo
   * @param callback
   */
  insertData(metricsInfo: MetricsInfo, callback): void {
    const valueBucket = generateBucket(metricsInfo);
    RdbUtils.insert('metricsInfo', valueBucket).then(result => {
      callback(result);
    });
    Logger.info('MetricsInfoTable', `Insert metricsInfo {${metricsInfo.id}:${metricsInfo.serverId}} finished.`);
  }

  /**
   * delete metricsInfo
   *
   * @param metricsInfo
   * @param callback
   */
  deleteDataByID(metricsInfo: MetricsInfo, callback): void {
    let predicates = new dataRdb.RdbPredicates(METRICS_INFO.tableName);
    // 根据id匹配要删除的数据
    predicates.equalTo('id', metricsInfo.id);
    RdbUtils.del(predicates).then(result => {
      callback(result);
    });
    Logger.info('MetricsInfoTable', `Delete metricsInfo {${metricsInfo.id}:${metricsInfo.serverId}} finished.`);
  }
  /**
   * query metricsInfo
   *
   * @param metricsInfo
   * @param callback
   */
  queryByServerId(serverId: number, callback): void {
    let predicates = new dataRdb.RdbPredicates(METRICS_INFO.tableName);
    predicates.equalTo('serverId', serverId);
    RdbUtils.query(predicates).then(resultSet => {
      let count = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        Logger.error('TaskInfoTable', `${serverId} query no results!`);
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result = [];
        for (let i = 0; i < count; i++) {
          let tmp = new MetricsInfo(0, 0, '', '', '', '', '', '', 0);
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.serverId = resultSet.getDouble(resultSet.getColumnIndex('serverId'));
          tmp.time = resultSet.getString(resultSet.getColumnIndex('time'));
          tmp.cpuUsage = resultSet.getString(resultSet.getColumnIndex('cpuUsage'));
          tmp.memoryUsage = resultSet.getString(resultSet.getColumnIndex('memoryUsage'));
          tmp.diskUsage = resultSet.getString(resultSet.getColumnIndex('diskUsage'));
          tmp.networkIn = resultSet.getString(resultSet.getColumnIndex('networkIn'));
          tmp.networkOut = resultSet.getString(resultSet.getColumnIndex('networkOut'));
          tmp.status = resultSet.getDouble(resultSet.getColumnIndex('status'));
          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }
}

function generateBucket(metricsInfo: MetricsInfo): dataRdb.ValuesBucket {
  let valueBucket = {};
  METRICS_INFO.columns.forEach((item: string) => {
    if (item !== 'id') {
      valueBucket[item] = metricsInfo[item];
    }
  });
  return valueBucket;
}

let taskInfoApi = new MetricsInfoApi();

export default taskInfoApi as MetricsInfoApi;
