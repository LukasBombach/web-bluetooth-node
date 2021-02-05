import { bluetooth } from "@web-bluetooth-node/test-adapter";
import { NodeBluetoothDevice } from "@web-bluetooth-node/test-adapter";
import type { NodeRequestDeviceOptions } from "@web-bluetooth-node/types";

describe("requestDevice", () => {
  test.each<NodeRequestDeviceOptions | undefined>([undefined])(
    "the params %s return the expected device",
    async options => {
      const device = await bluetooth.requestDevice(options, () => true);
      const filters = options?.filters || [];
      const name = filters.length ? filters[0].name : undefined;
      const uuids = options?.optionalServices?.map(s => s.toString());
      expect(device).toBeInstanceOf(NodeBluetoothDevice);
      expect(device.name).toBe(name);
      expect(device.uuids).toEqual(uuids);
    }
  );
});
