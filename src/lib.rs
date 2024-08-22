//! Implements Motoko runtime system

#![no_std]

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
   loop {}
}

#[no_mangle]
pub fn bug_repro() {
    use core::fmt::Write;
    let mut formatter = TestFormatter {};
    formatter.write_fmt(format_args!("{}", 0.0)).unwrap();
}

pub struct TestFormatter {
}

impl core::fmt::Write for TestFormatter {
    fn write_str(&mut self, _s: &str) -> core::fmt::Result {
        Ok(())
    }
}
