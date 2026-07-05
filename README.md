# AhaKey Developer Kit

中文 | [English](#english)

## 中文

AhaKey Developer Kit 是 AhaKey X1 的公开开发者入口，用于 BLE 协议接入、硬件 SDK 二创、示例项目和自定义 HEX 构建。

普通开发者应该优先使用本仓库里的 SDK、协议文档和 examples。用户自己构建的 HEX 是自定义开发者固件，不等同于 AhaKey 官方固件。

## 你可以用它做什么

- 编写自己的 Windows、macOS 或其他桌面端客户端。
- 通过 BLE 协议读取设备状态、同步 AI 状态、控制灯光和屏幕。
- 使用 SDK 自定义四个按键、拨杆、灯条、OLED 屏幕和基础通信逻辑。
- 基于 examples 快速构建可烧录到正版 AhaKey X1 硬件的自定义 HEX。
- 在保留官方 AhaKey Studio 兼容性的前提下，探索自己的 AI 编程工作流。

## 快速开始

第一版正式支持 Windows 构建流程。请在仓库根目录运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\check-env.ps1
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1
```

默认会构建 `examples/agent-status-display/`，输出文件为：

```text
build/agent-status-display/AhaKey-X1-agent-status-display.hex
```

## 入口导航

| 你想做什么 | 看哪里 |
|---|---|
| 写自己的电脑端客户端 | [docs/protocol-overview.md](docs/protocol-overview.md) |
| 了解 BLE 服务和命令 | [docs/ble-services.md](docs/ble-services.md) / [docs/commands.md](docs/commands.md) |
| 了解 AI 状态同步 | [docs/status-sync.md](docs/status-sync.md) |
| 保持官方桌面端兼容 | [docs/desktop-compatibility.md](docs/desktop-compatibility.md) |
| 改四个按键行为 | [sdk/buttons/](sdk/buttons/) + [examples/button-remap-demo/](examples/button-remap-demo/) |
| 改拨杆行为 | [sdk/toggle/](sdk/toggle/) + [examples/toggle-switch-demo/](examples/toggle-switch-demo/) |
| 改灯光效果 | [sdk/lights/](sdk/lights/) + [examples/light-status-demo/](examples/light-status-demo/) |
| 改 OLED 屏幕显示 | [sdk/display/](sdk/display/) + [examples/screen-hello-demo/](examples/screen-hello-demo/) |
| 编译自己的 HEX | [examples/custom-hex-demo/](examples/custom-hex-demo/) |
| 查看完整 examples | [examples/README.md](examples/README.md) |

## 仓库结构

```text
protocol/
├── README.md
├── LICENSE
├── CHANGELOG.md
├── compatibility.md
├── docs/
│   ├── protocol-overview.md
│   ├── ble-services.md
│   ├── commands.md
│   ├── status-sync.md
│   └── desktop-compatibility.md
├── sdk/
│   ├── core/
│   ├── buttons/
│   ├── toggle/
│   ├── lights/
│   ├── display/
│   ├── communication/
│   ├── battery/
│   └── build/
├── examples/
└── tools/
```

## SDK 模块

| 模块 | 用途 |
|---|---|
| `sdk/core/` | AhaKey SDK 核心头文件、二进制核心运行库和链接配置。 |
| `sdk/buttons/` | 四个主按键的短按、长按、双击和自定义动作接口。 |
| `sdk/toggle/` | 拨杆状态读取和自动批准 / 手动批准类工作流接口。 |
| `sdk/lights/` | 灯条、单颗灯珠颜色、AI 状态灯效和亮度控制接口。 |
| `sdk/display/` | OLED 区域绘制、文字、图片和状态展示接口。 |
| `sdk/communication/` | BLE / USB 通信封装和自定义命令范围说明。 |
| `sdk/battery/` | 电量、电压和充电状态读取接口。 |
| `sdk/build/` | Windows 环境检查和一键构建脚本。 |

## Examples

| 示例 | 说明 |
|---|---|
| `examples/button-remap-demo/` | 演示四个按键的默认 AI 编程快捷键映射。 |
| `examples/toggle-switch-demo/` | 演示拨杆上推 / 下推触发不同工作流。 |
| `examples/light-status-demo/` | 演示按 AI 状态切换不同灯效。 |
| `examples/screen-hello-demo/` | 演示 OLED 屏幕显示文字和状态。 |
| `examples/agent-status-display/` | 默认构建示例，演示 AI 编程状态、按键、拨杆、灯光和屏幕联动。 |
| `examples/custom-hex-demo/` | 演示如何组织自己的自定义 HEX 项目。 |

## 仓库边界

本仓库不包含官方完整固件源码、PCB、Gerber、BOM、生产测试资料或供应链资料。

## License

本仓库公开的文档、头文件、示例代码和构建脚本默认使用 [Apache License 2.0](LICENSE)。

`sdk/core/lib/libahakey_core.a` 是 AhaKey 二进制核心运行库，适用 [sdk/core/BINARY_LICENSE.md](sdk/core/BINARY_LICENSE.md) 中的授权边界。第三方工具链、WCH SDK、MounRiver 相关文件和供应商库继续适用其原始授权条款。

## English

AhaKey Developer Kit is the public developer entry point for AhaKey X1. It covers BLE protocol integration, hardware SDK customization, examples, and custom HEX builds.

Developers should start with this repository's SDK, protocol documentation, and examples. User-built HEX files are custom developer firmware and are not official AhaKey firmware.

## What You Can Build

- Build your own Windows, macOS, or other desktop client.
- Use the BLE protocol to read device status, sync AI states, control lights, and update the OLED display.
- Customize the four keys, toggle switch, LED strip, OLED display, and basic communication flow with the SDK.
- Build custom HEX files for genuine AhaKey X1 hardware from the examples.
- Explore AI coding workflows while keeping official AhaKey Studio compatibility in mind.

## Quick Start

The first public SDK release officially documents the Windows build flow. Run these commands from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\check-env.ps1
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1
```

The default example is `examples/agent-status-display/`. The default output is:

```text
build/agent-status-display/AhaKey-X1-agent-status-display.hex
```

## Entry Points

| Goal | Start here |
|---|---|
| Build a desktop client | [docs/protocol-overview.md](docs/protocol-overview.md) |
| Understand BLE services and commands | [docs/ble-services.md](docs/ble-services.md) / [docs/commands.md](docs/commands.md) |
| Understand AI status sync | [docs/status-sync.md](docs/status-sync.md) |
| Stay compatible with official desktop clients | [docs/desktop-compatibility.md](docs/desktop-compatibility.md) |
| Change four-button behavior | [sdk/buttons/](sdk/buttons/) + [examples/button-remap-demo/](examples/button-remap-demo/) |
| Change toggle behavior | [sdk/toggle/](sdk/toggle/) + [examples/toggle-switch-demo/](examples/toggle-switch-demo/) |
| Change LED effects | [sdk/lights/](sdk/lights/) + [examples/light-status-demo/](examples/light-status-demo/) |
| Change OLED display | [sdk/display/](sdk/display/) + [examples/screen-hello-demo/](examples/screen-hello-demo/) |
| Build custom HEX | [examples/custom-hex-demo/](examples/custom-hex-demo/) |
| Browse examples | [examples/README.md](examples/README.md) |

## Repository Layout

```text
protocol/
├── README.md
├── LICENSE
├── CHANGELOG.md
├── compatibility.md
├── docs/
├── sdk/
├── examples/
└── tools/
```

## SDK Modules

| Module | Purpose |
|---|---|
| `sdk/core/` | SDK headers, binary core runtime, and linker configuration. |
| `sdk/buttons/` | Four-key short press, long press, double click, and custom action APIs. |
| `sdk/toggle/` | Toggle state APIs for approval-style workflows. |
| `sdk/lights/` | LED strip, per-pixel color, AI status effects, and brightness APIs. |
| `sdk/display/` | OLED region drawing, text, image, and status display APIs. |
| `sdk/communication/` | BLE / USB communication wrappers and custom command range notes. |
| `sdk/battery/` | Battery, voltage, and charging state APIs. |
| `sdk/build/` | Windows environment check and build scripts. |

## Examples

| Example | Description |
|---|---|
| `examples/button-remap-demo/` | Four-key AI coding shortcut mapping. |
| `examples/toggle-switch-demo/` | Toggle-driven workflow behavior. |
| `examples/light-status-demo/` | AI-state LED effect switching. |
| `examples/screen-hello-demo/` | OLED text and status display. |
| `examples/agent-status-display/` | Default build example combining AI state, keys, toggle, lights, and OLED. |
| `examples/custom-hex-demo/` | Project layout for custom HEX builds. |

## Boundary

This repository does not include the full official firmware source, PCB, Gerber, BOM, production test materials, or supply-chain materials.

## License

Public documentation, headers, examples, and build scripts in this repository are released under the [Apache License 2.0](LICENSE).

`sdk/core/lib/libahakey_core.a` is the AhaKey binary core runtime and is governed by [sdk/core/BINARY_LICENSE.md](sdk/core/BINARY_LICENSE.md). Third-party toolchains, WCH SDK files, MounRiver-related files, and vendor libraries remain under their original license terms.
