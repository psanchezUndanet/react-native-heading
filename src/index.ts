import NativeReactNativeHeading from './NativeReactNativeHeading';
import { NativeEventEmitter } from 'react-native';

const emitter = new NativeEventEmitter(NativeReactNativeHeading);

export default {
  start: (filter: number) => NativeReactNativeHeading.start(filter),
  stop: () => NativeReactNativeHeading.stop(),
  addListener: (cb: (h: any) => void) => emitter.addListener('headingUpdated', cb),
};