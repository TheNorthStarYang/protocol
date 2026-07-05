# PRD: AhaKey Developer Kit

## 1. 项目背景

AhaKey 原 protocol 仓库主要用于 BLE 协议文档。随着 AhaKey X1 硬件 SDK 的出现，这个仓库需要升级为开发者入口，既服务第三方客户端开发，也服务硬件玩法二创。

## 2. 仓库新定位

本仓库定位为 **AhaKey Developer Kit**。

它包括：

- BLE 协议文档
- 官方桌面端兼容说明
- 硬件 SDK
- examples
- 自定义 HEX 构建和烧录说明
- 兼容性和版本策略

## 3. 目标用户

- 想写第三方客户端的人
- 想基于 BLE 协议做 workflow 的人
- 想改按键、拨杆、灯光、小屏幕的人
- 想生成自己的 HEX 并本地烧录体验的人

## 4. SDK 能力范围

第一版 SDK 目标是保留基础能力，同时开放可玩硬件资源。

基础能力：

- 蓝牙
- 通信
- 电池状态
- 电源管理
- 官方桌面端通信兼容

开放资源：

- 四个按键
- 拨杆 / toggle switch
- 灯光 / RGB / LED
- 小屏幕 / OLED display
- HID 输出
- AI 状态同步回调
- 用户自定义命令

## 5. 用户路径

| 用户目标 | 路径 |
|---|---|
| 写客户端 | `docs/protocol-overview.md` |
| 看 BLE 服务和命令 | `docs/ble-services.md` / `docs/commands.md` |
| 改硬件玩法 | `sdk/` + `examples/` |
| 展示项目 | awesome-ahakey |
| SDK 不够 | Hardware Source Access Program |

Hardware Source Access Program:

<https://ahakey.com/cn/hardware-source/apply>

## 6. 公开边界

公开：

- 协议文档
- SDK 公开头文件
- SDK 二进制核心库
- examples
- 构建和烧录说明
- 兼容性说明

不公开：

- 完整官方固件源码
- PCB layout
- Gerber
- BOM
- 生产测试资料
- 供应链资料

## 7. 版本兼容原则

- `0x00 - 0x9F` 为官方协议范围。
- `0xA0 - 0xEF` 为 SDK 用户自定义命令范围。
- `0xF0 - 0xFF` 为系统、调试和工厂保留范围。
- 官方后续开发不占用 `0xA0 - 0xEF`。
- 对已标记 Stable 的协议尽量保持兼容。
- Experimental 能力允许演进，但应在 CHANGELOG 中说明。

## 8. 后续 TODO

- 补齐 macOS / Linux 构建实测流程。
- 对每个 BLE 命令补充更严格的 payload 定义。
- 建立协议版本号和固件版本号映射。
- 增加更多完整项目示例。
- 补充第三方客户端最佳实践。

## 9. 旧文档处理

过期但仍有参考价值的旧 protocol 文档已复制到 `docs/archive/`。明显不符合当前 Developer Kit 定位的描述已由新 README 和新文档替换。
