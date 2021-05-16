use neon::prelude::*;

struct Point(usize, usize);

impl Finalize for Point {}

fn my_neon_function(mut cx: FunctionContext) -> JsResult<JsBox<Point>> {
    let point = cx.boxed(Point(0, 1));
    Ok(point)
}

#[neon::main]
fn main(mut cx: ModuleContext) -> NeonResult<()> {
    cx.export_function("test", my_neon_function).unwrap();
    Ok(())
}