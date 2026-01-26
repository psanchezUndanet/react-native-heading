import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  // IMPORTANTE: si vas a emitir eventos, RN espera estos dos métodos
  addListener(eventName: string): void;
  removeListeners(count: number): void;

  start(filter: number): Promise<boolean>;
  stop(): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('ReactNativeHeading');