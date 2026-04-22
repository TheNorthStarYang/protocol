[English](#english) | [简体中文](#简体中文)

---

# English

## AhaKey Protocol

This repository contains the public protocol documentation for AhaKey.

Its purpose is to help developers understand how AhaKey devices communicate, how host software interacts with them, and how community-built clients and integrations can be developed on top of the shared BLE protocol.

## What this repository covers

This repository documents the **public protocol surface** of AhaKey, especially:

- the custom BLE channel used by host-side tools
- device state query and state return behavior
- public command framing
- stable vs experimental protocol boundaries
- examples for third-party client development

## What this repository does not cover

This repository does **not** promise to document every internal firmware detail.

In particular, some low-level implementation details may remain undocumented or marked as internal, including:

- internal flash layout
- temporary runtime fields used during image transfer
- internal OLED rendering pipeline
- low-level WS2812 implementation details
- internal modes or behaviors that are not part of the public contract

## Protocol layers

AhaKey devices expose both:

1. standard BLE/HID-related services
2. an AhaKey-specific custom BLE channel

For community development, the most important part is the **AhaKey custom channel**.

## AhaKey custom channel

The current public custom BLE channel is centered around:

- Service `0x7340`
- Char1 `0x7341` — bulk data path
- Char3 `0x7343` — command path
- Char4 `0x7344` — notify / response path

In practice:

- subscribe to `0x7344` first
- send control commands to `0x7343`
- use `0x7341` only for bulk payloads such as image data flows that are explicitly documented

## Stability levels

This repository uses three protocol stability levels:

### Stable
Documented public behaviors that third-party clients may rely on.

### Experimental
Public but still evolving behaviors. These may change more easily.

### Internal
Implementation details that are not part of the public protocol contract.

See `docs/stability-policy.md` for details.

## Current documentation map

- `docs/overview.md` — protocol model and connection flow
- `docs/stability-policy.md` — stable / experimental / internal boundaries
- `docs/ble-services.md` — BLE services and characteristics
- `docs/events-and-states.md` — frames, states, and returned values
- `docs/commands.md` — command-level documentation
- `docs/public-vs-internal.md` — what is public and what should not be relied on

## Recommended reading order

If you are new to AhaKey protocol development, start with:

1. `docs/overview.md`
2. `docs/stability-policy.md`
3. `docs/ble-services.md`
4. `docs/events-and-states.md`
5. `docs/commands.md`

## Licensing

Unless otherwise noted:

- documentation in this repository is licensed under **CC BY 4.0**
- code in `examples/` is licensed under **MIT**

## Status

This repository is being documented in public.

Some sections may still include:

- incomplete field-level notes
- implementation-backed observations
- explicitly marked “to be confirmed” items

We prefer to document only what we can support from code and device behavior.

---

# 简体中文

## AhaKey 协议仓库

这个仓库用于公开 AhaKey 的协议文档。

它的目标，是帮助开发者理解：

- AhaKey 设备如何通信
- 主机软件如何与设备交互
- 社区如何基于共享 BLE 协议开发客户端和集成工具

## 这个仓库主要覆盖什么

这个仓库主要记录 AhaKey 的**公开协议面**，尤其是：

- 主机侧工具使用的自定义 BLE 通道
- 设备状态查询与状态返回行为
- 对外公开的命令帧格式
- 稳定能力与实验能力的边界
- 第三方客户端开发示例

## 这个仓库不覆盖什么

这个仓库**不会**承诺公开所有固件内部实现细节。

尤其以下内容可能不会完整公开，或者只会标记为 internal：

- flash 内部布局
- 图片传输过程中的临时运行态字段
- OLED 内部绘制管线
- WS2812 的底层实现细节
- 不属于公开契约的内部模式或行为

## 协议分层

AhaKey 设备同时暴露了两类协议层：

1. 标准 BLE / HID 相关服务
2. AhaKey 自定义 BLE 通道

对于社区开发者来说，最重要的是 **AhaKey 自定义通道**。

## AhaKey 自定义通道

当前公开的自定义 BLE 主通道主要围绕以下内容展开：

- Service `0x7340`
- Char1 `0x7341` — 大数据通道
- Char3 `0x7343` — 命令通道
- Char4 `0x7344` — 通知 / 回包通道

实际接入时建议这样理解：

- 先订阅 `0x7344`
- 再通过 `0x7343` 发送控制命令
- 只有在明确文档说明的场景下，才通过 `0x7341` 发送大数据正文

## 协议稳定性分级

这个仓库使用三种协议稳定性等级：

### Stable
已经对外公开、第三方客户端可以依赖的能力。

### Experimental
已经公开，但仍在演进中的能力，后续更容易变化。

### Internal
内部实现细节，不属于公开协议承诺范围。

详细说明见 `docs/stability-policy.md`。

## 当前文档导航

- `docs/overview.md` — 协议模型与连接流程
- `docs/stability-policy.md` — Stable / Experimental / Internal 边界
- `docs/ble-services.md` — BLE 服务与特征
- `docs/events-and-states.md` — 帧格式、状态和返回值
- `docs/commands.md` — 命令级文档
- `docs/public-vs-internal.md` — 哪些是公开能力，哪些不建议依赖

## 建议阅读顺序

如果你第一次接触 AhaKey 协议，建议按这个顺序阅读：

1. `docs/overview.md`
2. `docs/stability-policy.md`
3. `docs/ble-services.md`
4. `docs/events-and-states.md`
5. `docs/commands.md`

## 许可说明

除非另有说明：

- 本仓库文档默认使用 **CC BY 4.0**
- `examples/` 目录中的代码默认使用 **MIT**

## 当前状态

这个仓库正在公开整理中。

有些章节目前仍可能包含：

- 尚未完全补齐的字段级说明
- 基于代码行为整理出的观察项
- 明确标注为“待确认”的内容

我们的原则是：只记录当前能从代码和设备行为支持的信息。
