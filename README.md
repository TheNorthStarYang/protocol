# AhaKey Developer Kit

中文 | [English](#english)

## 中文

AhaKey Developer Kit 是 AhaKey 面向开发者的公开入口。这个仓库不再只是 BLE protocol 文档，而是同时包含：

- BLE 协议文档
- 官方桌面端通信兼容说明
- 硬件 SDK
- 四个按键开发接口
- 拨杆 / toggle switch 开发接口
- 灯光 / RGB / LED 开发接口
- 小屏幕 / OLED display 开发接口
- 自定义 HEX 构建和烧录参考
- examples 示例

开发者可以基于本仓库完成大多数客户端、workflow、按键、拨杆、灯光、小屏幕和自定义固件玩法。用户自定义 HEX 是开发者实验固件，不等于 AhaKey 官方固件。

## 入口导航

| 你想做什么 | 看哪里 |
|---|---|
| 写自己的电脑端客户端 | [docs/protocol-overview.md](docs/protocol-overview.md) |
| 了解 BLE 服务和命令 | [docs/ble-services.md](docs/ble-services.md) / [docs/commands.md](docs/commands.md) |
| 了解状态同步 | [docs/status-sync.md](docs/status-sync.md) |
| 保持官方桌面端兼容 | [docs/desktop-compatibility.md](docs/desktop-compatibility.md) |
| 改四个按键行为 | [sdk/buttons/](sdk/buttons/) + [examples/button-remap-demo/](examples/button-remap-demo/) |
| 改拨杆行为 | [sdk/toggle/](sdk/toggle/) + [examples/toggle-switch-demo/](examples/toggle-switch-demo/) |
| 改灯光效果 | [sdk/lights/](sdk/lights/) + [examples/light-status-demo/](examples/light-status-demo/) |
| 改小屏幕显示 | [sdk/display/](sdk/display/) + [examples/screen-hello-demo/](examples/screen-hello-demo/) |
| 编译自己的 HEX | [examples/custom-hex-demo/](examples/custom-hex-demo/) |
| 做完整项目展示 | awesome-ahakey |
| SDK 不够，需要完整官方源码 | [Hardware Source Access Program](https://ahakey.com/cn/hardware-source/apply) |

## 仓库边界

这个仓库是公开开发者入口。它开放协议、SDK、examples 和必要文档，让开发者完成大多数二创。

这个仓库不提供：

- 官方完整固件源码
- PCB layout
- Gerber
- BOM
- 生产测试资料
- 供应链资料

如果 SDK 仍然不够，再申请 Hardware Source Access Program：

<https://ahakey.com/cn/hardware-source/apply>

## 当前结构

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

## SDK 快速构建

第一版正式支持 Windows 构建流程。macOS / Linux 暂时只保留参考说明。

```powershell
powershell -ExecutionPolicy Bypass -File .\sdk\build\check-env.ps1
powershell -ExecutionPolicy Bypass -File .\sdk\build\build.ps1
```

默认构建：

```text
examples/agent-status-display/
```

输出：

```text
build/agent-status-display/AhaKey-X1-agent-status-display.hex
```

## English

AhaKey Developer Kit is the public developer entry point for AhaKey. This repository is no longer only a BLE protocol documentation repository. It now includes:

- BLE protocol documentation
- Official desktop compatibility notes
- Hardware SDK
- Four-button development APIs
- Toggle switch APIs
- RGB / LED APIs
- OLED display APIs
- Custom HEX build and flashing references
- Examples

Custom HEX files built by developers are experimental developer firmware. They are not official AhaKey firmware.

## Entry Points

| Goal | Start here |
|---|---|
| Build a desktop client | [docs/protocol-overview.md](docs/protocol-overview.md) |
| Understand BLE services and commands | [docs/ble-services.md](docs/ble-services.md) / [docs/commands.md](docs/commands.md) |
| Understand status sync | [docs/status-sync.md](docs/status-sync.md) |
| Stay compatible with official desktop clients | [docs/desktop-compatibility.md](docs/desktop-compatibility.md) |
| Change four-button behavior | [sdk/buttons/](sdk/buttons/) + [examples/button-remap-demo/](examples/button-remap-demo/) |
| Change toggle behavior | [sdk/toggle/](sdk/toggle/) + [examples/toggle-switch-demo/](examples/toggle-switch-demo/) |
| Change LED effects | [sdk/lights/](sdk/lights/) + [examples/light-status-demo/](examples/light-status-demo/) |
| Change OLED display | [sdk/display/](sdk/display/) + [examples/screen-hello-demo/](examples/screen-hello-demo/) |
| Build custom HEX | [examples/custom-hex-demo/](examples/custom-hex-demo/) |
| Showcase full projects | awesome-ahakey |
| Need full official source access | [Hardware Source Access Program](https://ahakey.com/cn/hardware-source/apply) |
