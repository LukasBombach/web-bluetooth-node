export interface NodeRequestDeviceOptions {
  filters?: BluetoothRequestDeviceFilter[];
  optionalServices?: BluetoothServiceUUID[];
  acceptAllDevices?: boolean;
}

export interface NodeBluetooth extends Omit<Bluetooth, "requestDevice"> {
  requestDevice(
    options?: NodeRequestDeviceOptions,
    callback?: (device: BluetoothDevice) => Promise<boolean> | boolean
  ): Promise<BluetoothDevice>;
}
