use neon::prelude::*;

use std::thread;
use std::time::Duration;
use std::sync::Arc;
use std::sync::Mutex;
use std::sync::mpsc::Receiver;
use std::sync::mpsc::channel;

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
    // adapter: Mutex<Adapter>,
    event_receiver: Receiver<CentralEvent>,
}

impl BleCentral {
    fn new() -> Self {
        let manager = Manager::new().unwrap();
        let adapters = manager.adapters().unwrap();
        let adapter = adapters.into_iter().nth(0).unwrap();
        let event_receiver = adapter.event_receiver().unwrap();

        // let adapter = Mutex::new(adapters.into_iter().nth(0).unwrap());
        // let event_receiver = adapter.event_receiver().unwrap(); // Arc::new(adapter.event_receiver().unwrap());

        BleCentral {
            adapter: adapter,
            event_receiver: event_receiver,
        }
    }

    fn start_scan(&self) -> () {
        // let e = Mutex::new(CentralEvent);

        // let event_receiver = Arc::new(self.adapter.event_receiver().unwrap());

        // let adapterMutex = &self.adapter;

        let (sender, receiver) = channel();
        self.adapter.start_scan().unwrap();
        sender.send(self.event_receiver.recv()).unwrap();


        let handle = thread::spawn(move || {
            // let adapter = adapterMutex.lock().unwrap();
            // let event_receiver = adapter.event_receiver().unwrap(); 
            // adapter.start_scan().unwrap();

            // let CentralE = e.lock().unwrap();
            // let receiver = Arc::clone(&event_receiver);


            while let Ok(event) = receiver.recv().unwrap() {
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
        handle.join().unwrap();
        thread::sleep(Duration::from_secs(2));
        self.stop_scan()
    }

    fn stop_scan(&self) -> () {
        self.adapter.stop_scan().unwrap();
    }

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
