import UIAbility from '@ohos.app.ability.UIAbility';
import Logger from '../common/utils/Logger';

export default class EntryAbility extends UIAbility {
  private static TAG: string = 'MainAbility';

  async onCreate(want, launchParam) {
    Logger.debug(EntryAbility.TAG, 'onCreate');
    globalThis.abilityWant = want;

  }

  onDestroy() {
    Logger.debug(EntryAbility.TAG, 'onDestroy');
  }

  onWindowStageCreate(windowStage) {
    // Main window is created, set main page for this ability
    Logger.debug(EntryAbility.TAG, 'onWindowStageCreate');
    windowStage.loadContent('pages/SplashPage', (err, data) => {
      if (err.code) {
        Logger.error('windowStage', 'Failed to load the content. Cause:' + JSON.stringify(err));
        return;
      }
      Logger.info('windowStage', 'Succeeded in loading the content. Data: ' + JSON.stringify(data));
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    Logger.debug(EntryAbility.TAG, 'onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    globalThis.isForeground = true;
    Logger.debug(EntryAbility.TAG, 'onForeground');
  }

  onBackground() {
    // Ability has back to background
    Logger.debug(EntryAbility.TAG, 'onBackground');
  }
  onNewWant(want, launchParam) {
    // Ability has new want
    Logger.debug(EntryAbility.TAG, `onNewWant ${JSON.stringify(want)}`);
    globalThis.abilityWant = want;
  }
}
