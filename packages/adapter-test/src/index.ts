import type { NodeBluetooth } from "@web-bluetooth-node/types";

interface NodeBluetoothDeviceOptions {
  readonly id: string;
  readonly watchingAdvertisements: boolean;
  readonly name?: string;
  readonly gatt?: BluetoothRemoteGATTServer;
  readonly uuids?: string[];
}

export const bluetooth: NodeBluetooth = {
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
