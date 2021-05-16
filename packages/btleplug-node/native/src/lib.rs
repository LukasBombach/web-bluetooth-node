use neon::prelude::*;
use neon::{declare_types, register_module};

pub struct Employee {
    id: i32,
    name: String
}

declare_types! {
    pub class JsEmployee for Employee {
        init(mut cx) {
            let id = cx.argument::<JsNumber>(0)?.value();
            let name: String = cx.argument::<JsString>(1)?.value();

            Ok(Employee {
                id: id as i32,
                name: name,
            })
        }

        method id(mut cx) {
            let this = cx.this();
            let id = {
                let guard = cx.lock();
                let greeter = this.borrow(&guard);
                format!("{}", greeter.id)
            };
            Ok(cx.string(&id).upcast())
        }

        method name(mut cx) {
            let this = cx.this();
            let name = {
                let guard = cx.lock();
                let greeter = this.borrow(&guard);
                format!("{}", greeter.name)
            };
            Ok(cx.string(&name).upcast())
        }


    }
}

register_module!(mut m, {
    m.export_class::<JsEmployee>("Employee")?;
    Ok(())
});