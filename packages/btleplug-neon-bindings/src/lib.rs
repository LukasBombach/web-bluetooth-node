use neon::prelude::*;
use std::thread;

extern crate btleplug;

use btleplug::api::{bleuuid::BleUuid, Central, CentralEvent};

#[cfg(target_os = "linux")]
use btleplug::bluez::{adapter::Adapter, manager::Manager};

#[cfg(target_os = "macos")]
use btleplug::corebluetooth::{adapter::Adapter, manager::Manager};

#[cfg(target_os = "windows")]
use btleplug::winrtble::{adapter::Adapter, manager::Manager};

pub struct BleCentral {
    adapter: Adapter,
}

impl BleCentral {
    fn new() -> Self {
        let manager = Manager::new().unwrap();
        let adapters = manager.adapters().unwrap();
        let adapter = adapters.into_iter().nth(0).unwrap();

        BleCentral {
            adapter: adapter,
        }
    }

    fn start_scan(&self) -> () {

        let adapter = self.adapter.clone();

        thread::spawn(move || {

            adapter.start_scan().unwrap();
            let event_receiver = adapter.event_receiver().unwrap();

            while let Ok(event) = event_receiver.recv() {
                match event {
                    CentralEvent::DeviceDiscovered(bd_addr) => {
                        println!("DeviceDiscovered: {:?}", bd_addr);
                    }
                    CentralEvent::DeviceConnected(bd_addr) => {
                        println!("DeviceConnected: {:?}", bd_addr);
                    }
                    CentralEvent::DeviceDisconnected(bd_addr) => {
                        println!("DeviceDisconnected: {:?}", bd_addr);
                    }
                    CentralEvent::ManufacturerDataAdvertisement {
                        address,
                        manufacturer_id,
                        data,
                    } => {
                        println!(
                            "ManufacturerDataAdvertisement: {:?}, {}, {:?}",
                            address, manufacturer_id, data
                        );
                    }
                    CentralEvent::ServiceDataAdvertisement {
                        address,
                        service,
                        data,
                    } => {
                        println!(
                            "ServiceDataAdvertisement: {:?}, {}, {:?}",
                            address,
                            service.to_short_string(),
                            data
                        );
                    }
                    CentralEvent::ServicesAdvertisement { address, services } => {
                        let services: Vec<String> =
                            services.into_iter().map(|s| s.to_short_string()).collect();
                        println!("ServicesAdvertisement: {:?}, {:?}", address, services);
                    }
                    _ => {}
                }
            }
        });
    }

    // fn stop_scan(&self) -> () {
    //     self.adapter.stop_scan().unwrap();
    // }

}


fn ble(mut cx: FunctionContext) -> JsResult<JsUndefined> {
    let central = BleCentral::new();
    central.start_scan();
    Ok(cx.undefined())
}

#[neon::main]
fn main(mut cx: ModuleContext) -> NeonResult<()> {
    cx.export_function("ble", ble)?;
    Ok(())
}
