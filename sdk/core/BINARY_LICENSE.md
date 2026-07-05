# AhaKey SDK Binary Core License Notice

中文 | [English](#english)

## 中文

本文件说明 `sdk/core/lib/libahakey_core.a` 的授权边界。

SDK 中公开的头文件、示例代码、文档和构建脚本可按 Apache-2.0 使用；`libahakey_core.a` 是 AhaKey 二进制核心运行库，不是完整官方固件源码，也不包含 AhaKey 的完整生产固件实现。

允许范围：

- 可将该二进制核心运行库用于正版 AhaKey 硬件的自定义固件构建。
- 可将该二进制核心运行库随 AhaKey Developer Kit / Firmware SDK 官方包一起分发。
- 可基于本 SDK 的公开头文件、示例和文档开发自定义按键、拨杆、灯光、屏幕和通信逻辑。

限制范围：

- 不得将该二进制核心运行库用于仿制硬件、非正版 AhaKey 硬件、竞争产品或任何规避正版硬件使用边界的项目。
- 不得反编译、反汇编、逆向、提取、修改或尝试还原该二进制核心运行库的内部实现，除非适用法律明确允许。
- 不得将该二进制核心运行库单独作为通用固件库、芯片 BSP、生产固件源码替代品或竞争产品组件分发。
- 不得使用该二进制核心运行库规避 AhaKey 的生产、测试、恢复、授权或安全机制。

该二进制授权说明不改变本仓库公开头文件、示例代码、文档和构建脚本的 Apache-2.0 授权。

第三方工具链、WCH SDK、MounRiver 相关文件和供应商库继续适用其原始授权条款。

## English

This notice defines the license boundary for `sdk/core/lib/libahakey_core.a`.

Public SDK headers, examples, documentation, and build scripts may be used under Apache-2.0. `libahakey_core.a` is the AhaKey binary core runtime. It is not the full official firmware source code and does not contain the complete AhaKey production firmware implementation.

Permitted use:

- You may use this binary core runtime to build custom firmware for genuine AhaKey hardware.
- You may redistribute this binary core runtime only as part of the official AhaKey Developer Kit / Firmware SDK package.
- You may build custom key, toggle, light, display, and communication logic using the public SDK headers, examples, and documentation.

Restrictions:

- You may not use this binary core runtime for clone hardware, non-genuine AhaKey hardware, competing products, or projects that bypass the intended genuine hardware boundary.
- You may not decompile, disassemble, reverse engineer, extract, modify, or attempt to reconstruct the internal implementation of this binary core runtime, except where explicitly allowed by applicable law.
- You may not distribute this binary core runtime as a standalone general-purpose firmware library, chip BSP, production firmware source replacement, or competing product component.
- You may not use this binary core runtime to bypass AhaKey production, testing, recovery, authorization, or security mechanisms.

This binary notice does not change the Apache-2.0 license for public SDK headers, examples, documentation, and build scripts in this repository.

Third-party toolchains, WCH SDK files, MounRiver-related files, and vendor libraries remain under their original license terms.
