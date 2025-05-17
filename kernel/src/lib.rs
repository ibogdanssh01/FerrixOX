#![no_std]
#![no_main]

use core::panic::PanicInfo;
use core::fmt::Write;

mod vga_buffer;

/// Called on panic
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    let mut writer = vga_buffer::WRITER.lock();
    writeln!(writer, "\n--- KERNEL PANIC ---").ok();

    if let Some(location) = info.location() {
        writeln!(writer, "At {}:{}", location.file(), location.line()).ok();
    } else {
        writeln!(writer, "No panic location available.").ok();
    }

    if let Some(message) = info.message() {
        writeln!(writer, "Message: {}", message).ok();
    }

    loop {}
}

/// Kernel entry point
#[no_mangle]
pub extern "C" fn _start() -> ! {
    let mut writer = vga_buffer::WRITER.lock();
    writeln!(writer, "Welcome to FerrixOX!").ok();
    writeln!(writer, "Rust kernel booted successfully.").ok();

    loop {}
}
