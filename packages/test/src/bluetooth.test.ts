import { bluetooth } from "@web-bluetooth-node/test-adapter";
import { NodeBluetoothDevice } from "@web-bluetooth-node/test-adapter";
import type { NodeRequestDeviceOptions } from "@web-bluetooth-node/types";

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
