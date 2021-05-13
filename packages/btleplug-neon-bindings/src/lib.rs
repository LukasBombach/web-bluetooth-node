use neon::prelude::*;

use std::thread;
use std::time::Duration;

use simple_logger::SimpleLogger;

use btleplug::corebluetooth::{adapter::Adapter, manager::Manager};
use btleplug::api::{bleuuid::uuid_from_u16, Central, Peripheral, WriteType};
use uuid::Uuid;


fn ble(mut cx: FunctionContext) -> JsResult<JsUndefined> {
    SimpleLogger::new().init().unwrap();
    let manager = Manager::new().unwrap();
    let adapter_list = manager.adapters().unwrap();
    if adapter_list.len() <= 0 {
        eprint!("Bluetooth adapter(s) were NOT found, sorry...\n");
    } else {
        for adapter in adapter_list.iter() {
            println!("connecting to BLE adapter: ...");

            adapter
                .start_scan()
                .expect("Can't scan BLE adapter for connected devices...");
            thread::sleep(Duration::from_secs(2));
            if adapter.peripherals().is_empty() {
                eprintln!("->>> BLE peripheral devices were not found, sorry. Exiting...");
            } else {
                // all peripheral devices in range
                for peripheral in adapter.peripherals().iter() {
                    println!(
                        "peripheral : {:?} is connected: {:?}",
                        peripheral.properties().local_name,
                        peripheral.is_connected()
                    );
                    if peripheral.properties().local_name.is_some() && !peripheral.is_connected() {
                        println!(
                            "start connect to peripheral : {:?}...",
                            peripheral.properties().local_name
                        );
                        peripheral
                            .connect()
                            .expect("Can't connect to peripheral...");
                        println!(
                            "now connected (\'{:?}\') to peripheral : {:?}...",
                            peripheral.is_connected(),
                            peripheral.properties().local_name
                        );
                        let chars = peripheral.discover_characteristics();
                        if peripheral.is_connected() {
                            println!(
                                "Discover peripheral : \'{:?}\' characteristics...",
                                peripheral.properties().local_name
                            );
                            for chars_vector in chars.into_iter() {
                                for char_item in chars_vector.iter() {
                                    println!("{:?}", char_item);
                                }
                            }
                            println!(
                                "disconnecting from peripheral : {:?}...",
                                peripheral.properties().local_name
                            );
                            peripheral
                                .disconnect()
                                .expect("Error on disconnecting from BLE peripheral ");
                        }
                    } else {
                        //sometimes peripheral is not discovered completely
                        eprintln!("SKIP connect to UNKNOWN peripheral : {:?}", peripheral);
                    }
                }
            }
        }
    }
    Ok(cx.undefined())
}


fn hello(mut cx: FunctionContext) -> JsResult<JsString> {
    Ok(cx.string("hello node"))
}

#[neon::main]
fn main(mut cx: ModuleContext) -> NeonResult<()> {
    cx.export_function("hello", hello)?;
    cx.export_function("ble", ble)?;
    Ok(())
}
