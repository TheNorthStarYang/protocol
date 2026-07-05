<a id="top"></a>

<p align="center">
  <a href="#zh-cn"><strong>简体中文</strong></a> ·
  <a href="#en"><strong>English</strong></a>
</p>

---

<a id="zh-cn"></a>

<h1 align="center">🧩 AhaKey Developer Kit</h1>

<p align="center">
  <strong>AhaKey X1 的 BLE 协议、硬件 SDK、examples 与自定义 HEX 开发入口</strong>
</p>

<p align="center">
  BLE Protocol · Hardware SDK · Buttons · Toggle · Lights · OLED · Custom HEX
</p>

<p align="center">
  <a href="https://github.com/AhakeyAI/protocol"><img alt="protocol" src="https://img.shields.io/badge/Protocol-BLE-26A69A"></a>
  <a href="./sdk"><img alt="sdk" src="https://img.shields.io/badge/SDK-Hardware-5C6BC0"></a>
  <a href="./examples"><img alt="examples" src="https://img.shields.io/badge/Examples-Demos-43A047"></a>
  <a href="./compatibility.md"><img alt="compatibility" src="https://img.shields.io/badge/Compatibility-Docs-orange"></a>
  <a href="./LICENSE"><img alt="license" src="https://img.shields.io/badge/License-Apache--2.0-blue"></a>
</p>

---

## AhaKey Developer Kit 是什么？

AhaKey Developer Kit 是 AhaKey X1 面向开发者的公开入口。

它不再只是 BLE 协议文档，而是同时包含：

* BLE 协议文档
* 官方桌面端通信兼容说明
* 硬件 SDK
* 四个按键开发接口
* 拨杆 / toggle switch 开发接口
* 灯光 / RGB / LED 开发接口
* 小屏幕 / OLED display 开发接口
* 自定义 HEX 构建和烧录参考
* examples 示例项目

普通开发者应该优先使用本仓库里的 SDK、协议文档和 examples。
用户自己构建的 HEX 是自定义开发者固件，不等同于 AhaKey 官方固件。

---

## 你可以用它做什么？

```text
BLE 协议接入
→ 官方桌面端兼容
→ 硬件 SDK 二创
→ 按键 / 拨杆 / 灯光 / OLED 自定义
→ 构建自己的 HEX
→ 本地烧录到正版 AhaKey X1 硬件
```

适合：

* 编写自己的 Windows、macOS 或其他桌面端客户端
* 通过 BLE 协议读取设备状态、同步 AI 状态、控制灯光和屏幕
* 使用 SDK 自定义四个按键、拨杆、灯条、OLED 屏幕和基础通信逻辑
* 基于 examples 快速构建可烧录到正版 AhaKey X1 硬件的自定义 HEX
* 在保留官方 AhaKey Studio 兼容性的前提下，探索自己的 AI 编程工作流

---

## 快速开始

第一版正式支持 Windows 构建流程。请在仓库根目录运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\check-env.ps1
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1
```

默认会构建：

```text
examples/agent-status-display/
```

输出文件为：

```text
build/agent-status-display/AhaKey-X1-agent-status-display.hex
```

---

## 你来到这里，通常是想做这些事

| 你想做什么         | 看哪里                                                                                           | 说明                                         |
| ------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------ |
| 写自己的电脑端客户端    | [`docs/protocol-overview.md`](docs/protocol-overview.md)                                      | 了解 AhaKey 设备通信方式和客户端接入逻辑                   |
| 了解 BLE 服务和命令  | [`docs/ble-services.md`](docs/ble-services.md) / [`docs/commands.md`](docs/commands.md)       | 查看 BLE service、characteristic 和 command 定义 |
| 了解 AI 状态同步    | [`docs/status-sync.md`](docs/status-sync.md)                                                  | 让设备显示 AI 编程状态、任务状态或桌面状态                    |
| 保持官方桌面端兼容     | [`docs/desktop-compatibility.md`](docs/desktop-compatibility.md)                              | 自定义固件仍能与官方 AhaKey Studio 协作                |
| 改四个按键行为       | [`sdk/buttons/`](sdk/buttons/) + [`examples/button-remap-demo/`](examples/button-remap-demo/) | 自定义短按、长按、双击和快捷动作                           |
| 改拨杆行为         | [`sdk/toggle/`](sdk/toggle/) + [`examples/toggle-switch-demo/`](examples/toggle-switch-demo/) | 定义自动批准 / 手动批准等工作流                          |
| 改灯光效果         | [`sdk/lights/`](sdk/lights/) + [`examples/light-status-demo/`](examples/light-status-demo/)   | 根据 AI 状态、按键状态或自定义事件切换灯效                    |
| 改 OLED 屏幕显示   | [`sdk/display/`](sdk/display/) + [`examples/screen-hello-demo/`](examples/screen-hello-demo/) | 显示文字、状态、图标或简单界面                            |
| 编译自己的 HEX     | [`examples/custom-hex-demo/`](examples/custom-hex-demo/)                                      | 参考自定义项目结构并生成可烧录文件                          |
| 查看完整 examples | [`examples/README.md`](examples/README.md)                                                    | 浏览全部示例项目和当前完成状态                            |

---

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

---

## SDK 模块

| 模块                                         | 用途                             |
| ------------------------------------------ | ------------------------------ |
| [`sdk/core/`](sdk/core/)                   | AhaKey SDK 核心头文件、二进制核心运行库和链接配置 |
| [`sdk/buttons/`](sdk/buttons/)             | 四个主按键的短按、长按、双击和自定义动作接口         |
| [`sdk/toggle/`](sdk/toggle/)               | 拨杆状态读取和自动批准 / 手动批准类工作流接口       |
| [`sdk/lights/`](sdk/lights/)               | 灯条、单颗灯珠颜色、AI 状态灯效和亮度控制接口       |
| [`sdk/display/`](sdk/display/)             | OLED 区域绘制、文字、图片和状态展示接口         |
| [`sdk/communication/`](sdk/communication/) | BLE / USB 通信封装和自定义命令范围说明       |
| [`sdk/battery/`](sdk/battery/)             | 电量、电压和充电状态读取接口                 |
| [`sdk/build/`](sdk/build/)                 | Windows 环境检查和一键构建脚本            |

---

## Examples

| 示例                                                                 | 说明                              |
| ------------------------------------------------------------------ | ------------------------------- |
| [`examples/button-remap-demo/`](examples/button-remap-demo/)       | 演示四个按键的默认 AI 编程快捷键映射            |
| [`examples/toggle-switch-demo/`](examples/toggle-switch-demo/)     | 演示拨杆上推 / 下推触发不同工作流              |
| [`examples/light-status-demo/`](examples/light-status-demo/)       | 演示按 AI 状态切换不同灯效                 |
| [`examples/screen-hello-demo/`](examples/screen-hello-demo/)       | 演示 OLED 屏幕显示文字和状态               |
| [`examples/agent-status-display/`](examples/agent-status-display/) | 默认构建示例，演示 AI 编程状态、按键、拨杆、灯光和屏幕联动 |
| [`examples/custom-hex-demo/`](examples/custom-hex-demo/)           | 演示如何组织自己的自定义 HEX 项目             |

---

## 推荐开发路径

### 1）我想写自己的桌面客户端

```text
阅读 docs/protocol-overview.md
→ 查看 BLE service 和 commands
→ 参考状态同步文档
→ 实现自己的客户端或 workflow
→ 提交到 awesome-ahakey 展示
```

适合：

* 第三方 Windows / macOS 客户端
* Cursor / Claude / Codex workflow 工具
* 状态同步工具
* 快捷键脚本
* 自动化集成

---

### 2）我想改 AhaKey X1 的按键、拨杆、灯光或屏幕

```text
阅读 sdk/README.md
→ 选择对应 SDK 模块
→ 参考 examples
→ 构建自己的 HEX
→ 本地烧录到正版 AhaKey X1 硬件
```

适合：

* 改四个按键行为
* 改拨杆逻辑
* 改灯效
* 改 OLED 显示
* 做自己的 AI 编程状态提示
* 做自己的桌面交互玩法

---

### 3）我想做一个完整项目并分享给社区

```text
基于 protocol / sdk / examples 做出项目
→ 整理 README、截图、视频或使用说明
→ 提交到 awesome-ahakey
→ 让更多用户看到、学习和 Fork
```

适合：

* 第三方客户端
* 自定义固件玩法
* workflow preset
* 使用教程
* 视频 / 图文教程
* 桌面 setup 展示

---

## 仓库边界

本仓库是 AhaKey X1 的公开开发者入口，面向协议接入、SDK 二创、examples 和自定义 HEX 构建。

本仓库不包含：

* 官方完整固件源码
* PCB layout
* Gerber
* BOM
* 生产测试资料
* 供应链资料

用户自定义 HEX 是开发者实验固件，不等同于 AhaKey 官方固件。
请不要将自定义 HEX 描述为官方固件，也不要将其用于冒充官方发布版本。

---

## 贡献方式

你可以贡献：

* 文档修正
* BLE 协议反馈
* SDK 使用反馈
* examples 改进
* 构建脚本改进
* 自定义客户端示例
* 自定义按键 / 拨杆 / 灯光 / OLED demo
* 使用教程、截图或视频说明

建议尽量保持：

* 小步提交
* 说明清楚
* 有截图 / 日志 / demo 更好
* 不提交密钥、token、私人文件
* 大功能先 Discussion，再 PR
* 不提交官方完整固件源码、PCB、Gerber、BOM 或生产资料

---

## License

本仓库公开的文档、头文件、示例代码和构建脚本默认使用 [Apache License 2.0](LICENSE)。

[`sdk/core/lib/libahakey_core.a`](sdk/core/lib/) 是 AhaKey 二进制核心运行库，适用 [`sdk/core/BINARY_LICENSE.md`](sdk/core/BINARY_LICENSE.md) 中的授权边界。

第三方工具链、WCH SDK、MounRiver 相关文件和供应商库继续适用其原始授权条款。

---

<p align="right"><a href="#top">↑ Back to top</a></p>

---

<a id="en"></a>

<h1 align="center">🧩 AhaKey Developer Kit</h1>

<p align="center">
  <strong>BLE protocol, hardware SDK, examples, and custom HEX development entry for AhaKey X1</strong>
</p>

<p align="center">
  BLE Protocol · Hardware SDK · Buttons · Toggle · Lights · OLED · Custom HEX
</p>

<p align="center">
  <a href="https://github.com/AhakeyAI/protocol"><img alt="protocol" src="https://img.shields.io/badge/Protocol-BLE-26A69A"></a>
  <a href="./sdk"><img alt="sdk" src="https://img.shields.io/badge/SDK-Hardware-5C6BC0"></a>
  <a href="./examples"><img alt="examples" src="https://img.shields.io/badge/Examples-Demos-43A047"></a>
  <a href="./compatibility.md"><img alt="compatibility" src="https://img.shields.io/badge/Compatibility-Docs-orange"></a>
  <a href="./LICENSE"><img alt="license" src="https://img.shields.io/badge/License-Apache--2.0-blue"></a>
</p>

---

## What is AhaKey Developer Kit?

AhaKey Developer Kit is the public developer entry point for AhaKey X1.

It is no longer only a BLE protocol documentation repository. It now includes:

* BLE protocol documentation
* Official desktop compatibility notes
* Hardware SDK
* Four-button development APIs
* Toggle switch APIs
* RGB / LED APIs
* OLED display APIs
* Custom HEX build and flashing references
* Example projects

Developers should start with this repository's SDK, protocol documentation, and examples.
User-built HEX files are custom developer firmware and are not official AhaKey firmware.

---

## What can you build with it?

```text
BLE protocol integration
→ Official desktop compatibility
→ Hardware SDK customization
→ Buttons / toggle / lights / OLED customization
→ Build your own HEX
→ Flash it locally to genuine AhaKey X1 hardware
```

This is useful for:

* Building your own Windows, macOS, or other desktop client
* Reading device status, syncing AI states, and controlling lights or OLED over BLE
* Customizing the four keys, toggle switch, LED strip, OLED display, and basic communication flow with the SDK
* Building custom HEX files for genuine AhaKey X1 hardware from examples
* Exploring AI coding workflows while keeping official AhaKey Studio compatibility in mind

---

## Quick Start

The first public SDK release officially documents the Windows build flow. Run these commands from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\check-env.ps1
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1
```

The default example is:

```text
examples/agent-status-display/
```

The default output is:

```text
build/agent-status-display/AhaKey-X1-agent-status-display.hex
```

---

## Start here

| Goal                                          | Start here                                                                                    | Notes                                                            |
| --------------------------------------------- | --------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| Build a desktop client                        | [`docs/protocol-overview.md`](docs/protocol-overview.md)                                      | Learn how AhaKey communicates with desktop clients               |
| Understand BLE services and commands          | [`docs/ble-services.md`](docs/ble-services.md) / [`docs/commands.md`](docs/commands.md)       | BLE services, characteristics, and command definitions           |
| Understand AI status sync                     | [`docs/status-sync.md`](docs/status-sync.md)                                                  | Show AI coding state, task state, or desktop state on the device |
| Stay compatible with official desktop clients | [`docs/desktop-compatibility.md`](docs/desktop-compatibility.md)                              | Keep custom firmware compatible with AhaKey Studio               |
| Change four-button behavior                   | [`sdk/buttons/`](sdk/buttons/) + [`examples/button-remap-demo/`](examples/button-remap-demo/) | Customize short press, long press, double click, and actions     |
| Change toggle behavior                        | [`sdk/toggle/`](sdk/toggle/) + [`examples/toggle-switch-demo/`](examples/toggle-switch-demo/) | Define approval-style workflows                                  |
| Change LED effects                            | [`sdk/lights/`](sdk/lights/) + [`examples/light-status-demo/`](examples/light-status-demo/)   | Change lights based on AI state, key state, or custom events     |
| Change OLED display                           | [`sdk/display/`](sdk/display/) + [`examples/screen-hello-demo/`](examples/screen-hello-demo/) | Display text, states, icons, or simple UI                        |
| Build custom HEX                              | [`examples/custom-hex-demo/`](examples/custom-hex-demo/)                                      | Use the custom project layout to generate flashable files        |
| Browse examples                               | [`examples/README.md`](examples/README.md)                                                    | See all example projects and their current status                |

---

## Repository layout

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

---

## SDK modules

| Module                                     | Purpose                                                                |
| ------------------------------------------ | ---------------------------------------------------------------------- |
| [`sdk/core/`](sdk/core/)                   | SDK headers, binary core runtime, and linker configuration             |
| [`sdk/buttons/`](sdk/buttons/)             | Four-key short press, long press, double click, and custom action APIs |
| [`sdk/toggle/`](sdk/toggle/)               | Toggle state APIs for approval-style workflows                         |
| [`sdk/lights/`](sdk/lights/)               | LED strip, per-pixel color, AI status effects, and brightness APIs     |
| [`sdk/display/`](sdk/display/)             | OLED region drawing, text, image, and status display APIs              |
| [`sdk/communication/`](sdk/communication/) | BLE / USB communication wrappers and custom command range notes        |
| [`sdk/battery/`](sdk/battery/)             | Battery, voltage, and charging state APIs                              |
| [`sdk/build/`](sdk/build/)                 | Windows environment check and build scripts                            |

---

## Examples

| Example                                                            | Description                                                              |
| ------------------------------------------------------------------ | ------------------------------------------------------------------------ |
| [`examples/button-remap-demo/`](examples/button-remap-demo/)       | Four-key AI coding shortcut mapping                                      |
| [`examples/toggle-switch-demo/`](examples/toggle-switch-demo/)     | Toggle-driven workflow behavior                                          |
| [`examples/light-status-demo/`](examples/light-status-demo/)       | AI-state LED effect switching                                            |
| [`examples/screen-hello-demo/`](examples/screen-hello-demo/)       | OLED text and status display                                             |
| [`examples/agent-status-display/`](examples/agent-status-display/) | Default build example combining AI state, keys, toggle, lights, and OLED |
| [`examples/custom-hex-demo/`](examples/custom-hex-demo/)           | Project layout for custom HEX builds                                     |

---

## Recommended paths

### 1) I want to build my own desktop client

```text
Read docs/protocol-overview.md
→ Check BLE services and commands
→ Read status sync docs
→ Build your own client or workflow
→ Submit it to awesome-ahakey
```

Best for:

* Third-party Windows / macOS clients
* Cursor / Claude / Codex workflow tools
* Status sync tools
* Shortcut scripts
* Automation integrations

---

### 2) I want to customize AhaKey X1 buttons, toggle, lights, or display

```text
Read sdk/README.md
→ Choose the SDK module
→ Check examples
→ Build your own HEX
→ Flash it locally to genuine AhaKey X1 hardware
```

Best for:

* Changing four-button behavior
* Changing toggle logic
* Changing LED effects
* Changing OLED display
* Building your own AI coding status indicator
* Creating custom desktop interaction behaviors

---

### 3) I built a complete project and want to share it

```text
Build something with protocol / sdk / examples
→ Prepare README, screenshots, videos, or usage notes
→ Submit it to awesome-ahakey
→ Help more users discover, learn from, and fork it
```

Best for:

* Third-party clients
* Custom firmware experiences
* Workflow presets
* Tutorials
* Videos / written guides
* Desk setup showcases

---

## Boundary

This repository is the public developer entry point for AhaKey X1, covering protocol integration, SDK customization, examples, and custom HEX builds.

This repository does not include:

* Full official firmware source
* PCB layout
* Gerber
* BOM
* Production test materials
* Supply-chain materials

User-built HEX files are experimental developer firmware and are not official AhaKey firmware.
Please do not describe custom HEX files as official firmware or use them to impersonate official releases.

---

## Ways to contribute

You can contribute:

* documentation improvements
* BLE protocol feedback
* SDK usage feedback
* example improvements
* build script improvements
* custom client examples
* custom button / toggle / LED / OLED demos
* tutorials, screenshots, or videos

Please try to keep contributions:

* small and reviewable
* clearly explained
* accompanied by screenshots / logs / demos when helpful
* free of secrets, tokens, or personal files
* discussed first if the feature is large
* free of official full firmware source, PCB, Gerber, BOM, or production materials

---

## License

Public documentation, headers, examples, and build scripts in this repository are released under the [Apache License 2.0](LICENSE).

[`sdk/core/lib/libahakey_core.a`](sdk/core/lib/) is the AhaKey binary core runtime and is governed by [`sdk/core/BINARY_LICENSE.md`](sdk/core/BINARY_LICENSE.md).

Third-party toolchains, WCH SDK files, MounRiver-related files, and vendor libraries remain under their original license terms.

---

<p align="right"><a href="#top">↑ Back to top</a></p>
