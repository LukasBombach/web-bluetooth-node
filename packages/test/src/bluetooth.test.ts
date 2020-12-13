export interface NodeBluetooth extends Omit<Bluetooth, "requestDevice"> {
  requestDevice(
    options?: NodeRequestDeviceOptions,
    callback?: (device: NodeBluetoothDevice) => Promise<boolean> | boolean
  ): Promise<BluetoothDevice>;
}

interface NodeRequestDeviceOptions {
  filters?: BluetoothRequestDeviceFilter[];
  optionalServices?: BluetoothServiceUUID[];
  acceptAllDevices?: boolean;
}

const bluetooth: NodeBluetooth = {
  requestDevice: async (options, callback) => {
    const id = "1";
    const watchingAdvertisements = false;
    const name = (options?.filters?.length
      ? options.filters[0].name
      : undefined) as string | undefined;
    const uuids = options?.optionalServices?.map(uuid => uuid.toString());
    return new NodeBluetoothDevice({ id, watchingAdvertisements, name, uuids });
  },
} as NodeBluetooth;

interface NodeBluetoothDeviceOptions {
  id: string;
  watchingAdvertisements: boolean;
  name?: string;
  gatt?: BluetoothRemoteGATTServer;
  uuids?: string[];
}

export class NodeBluetoothDevice implements BluetoothDevice {
  readonly id: string;
  readonly watchingAdvertisements: boolean;
  readonly name?: string;
  readonly gatt?: BluetoothRemoteGATTServer;
  readonly uuids?: string[];

  constructor(options: NodeBluetoothDeviceOptions) {
    this.id = options.id;
    this.watchingAdvertisements = options.watchingAdvertisements;
    this.name = options.name;
    this.gatt = options.gatt;
    this.uuids = options.uuids;
  }

  async watchAdvertisements(): Promise<void> {}
  unwatchAdvertisements(): void {}
}

describe("requestDevice", () => {
  // TODO generate brute force options
  test.each<NodeRequestDeviceOptions | undefined>([
    undefined,
    { filters: [] },
    { filters: [{ name: "name" }] },
    { filters: [], optionalServices: [] },
    { filters: [], optionalServices: [1] },
    { filters: [{ name: "name" }], optionalServices: [1] },
    { filters: [{ name: "name" }], optionalServices: ["1"] },
  ])("the params %s return the expected device", async options => {
    const device = await bluetooth.requestDevice(options, () => true);
    const name = options?.filters?.length ? options.filters[0].name : undefined;
    const uuids = options?.optionalServices?.map(s => s.toString());
    expect(device).toBeInstanceOf(NodeBluetoothDevice);
    expect(device.name).toBe(name);
    expect(device.uuids).toEqual(uuids);
  });
});
