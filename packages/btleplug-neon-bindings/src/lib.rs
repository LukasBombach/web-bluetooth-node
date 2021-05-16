use neon::prelude::*;
use std::cell::RefCell;

type BoxedPerson = JsBox<RefCell<Person>>;

struct Person {
    name: String,
}

impl Finalize for Person {}

impl Person {
    pub fn new(name: String) -> Self {
        Person { name }
    }

    pub fn set_name(&mut self, name: String) {
        self.name = name;
    }

    pub fn greet(&self) -> String {
        format!("Hello, {}!", self.name)
    }
}

fn person_new(mut cx: FunctionContext) -> JsResult<BoxedPerson> {
    let name = cx.argument::<JsString>(0)?.value(&mut cx);
    let person = RefCell::new(Person::new(name));

    Ok(cx.boxed(person))
}

fn person_set_name(mut cx: FunctionContext) -> JsResult<JsUndefined> {
    let person = cx.argument::<BoxedPerson>(0)?;
    let mut person = person.borrow_mut();
    let name = cx.argument::<JsString>(1)?.value(&mut cx);

    person.set_name(name);

    Ok(cx.undefined())
}

fn person_greet(mut cx: FunctionContext) -> JsResult<JsString> {
    let person = cx.argument::<BoxedPerson>(0)?;
    let person = person.borrow();
    let greeting = person.greet();

    Ok(cx.string(greeting))
}


#[neon::main]
fn main(mut cx: ModuleContext) -> NeonResult<()> {
    cx.export_function("person_new", person_new)?;
    cx.export_function("person_set_name", person_set_name)?;
    cx.export_function("person_greet", person_greet)?;
    Ok(())
}
