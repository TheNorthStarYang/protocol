[English](#english) | [简体中文](#简体中文)

---

# English

## Protocol Stability Policy

This document explains how AhaKey classifies protocol behaviors and what third-party developers should rely on.

The goal is to make the protocol usable for community development without freezing every internal firmware detail too early.

## Stability levels

### Stable

**Stable** means:

- part of the public AhaKey protocol surface
- intended for third-party clients to rely on
- expected to remain compatible unless clearly documented otherwise

Stable does **not** mean the protocol will never evolve.  
It means changes should be deliberate, documented, and treated as compatibility-sensitive.

### Experimental

**Experimental** means:

- public enough for community experimentation
- useful for early adopters and advanced tools
- more likely to change as firmware and tooling evolve

Experimental features should be used with caution.  
They are visible and usable, but not yet promised as long-term stable behavior.

### Internal

**Internal** means:

- implementation detail
- not part of the public compatibility contract
- may change without public compatibility guarantees

Third-party tools should avoid depending on internal details.

---

## Current stable protocol surface

The following areas are currently treated as **Stable**:

### Stable transport and command flow
- custom service `0x7340`
- command write path on `0x7343`
- notify / response path on `0x7344`

### Stable command-level capabilities
- `0x00` state query / state return
- `0x04` save configuration
- `0x73` key configuration container
- `0x83` image metadata query
- `0x90` Claude state synchronization

### Stable returned state fields
The current state frame is treated as stable at the field level for:

- battery
- firmware main version
- firmware sub version
- mode
- light
- switch state
- reserved field position

The meaning of some values may still be refined in documentation, but the frame itself is part of the public contract.

---

## Current experimental protocol surface

The following areas are currently treated as **Experimental**:

- `0x80` image / flash write initialization
- raw bulk payload transfer on `0x7341`
- `0x82` image metadata update
- `0x01` device name update
- `0x02` appearance update

These features are public enough to document, but they are not yet recommended as long-term stable integration targets.

---

## Current internal areas

The following areas are currently treated as **Internal**:

- flash addresses and storage layout
- temporary fields used during image transfer
- internal image write progress details
- internal OLED rendering logic
- exact WS2812 implementation details
- full internal meaning of mode values not intended for client control
- implementation-only runtime fields that are not part of returned public frames

---

## How to use this policy

If you are building a third-party client:

### Safe to depend on
- stable transport path
- stable commands
- stable returned state fields

### Use carefully
- experimental image and bulk-transfer flows
- experimental metadata-changing commands

### Avoid depending on
- internal runtime and storage details
- undocumented side effects
- behaviors marked as internal or “to be confirmed”

---

## How protocol changes should be documented

When the protocol changes, updates should ideally include:

- whether the change affects Stable, Experimental, or Internal areas
- whether compatibility is preserved
- whether a client update is required
- whether old behavior is deprecated or removed

Stable-area changes should be documented more carefully than internal changes.

---

## Design principle

AhaKey does not want to expose every firmware implementation detail as public API.

The public protocol should describe **product behavior**, not every internal mechanism.

Examples:

### Good public protocol surface
- query current state
- update Claude state
- configure keys in a given mode
- query image slot metadata

### Usually not good public protocol surface
- raw internal flash address management
- temporary runtime transfer counters
- undocumented rendering internals

---

# 简体中文

## 协议稳定性策略

这份文档用于说明 AhaKey 如何给协议能力分级，以及第三方开发者应该依赖什么、不应该依赖什么。

目标是：既让社区可以真正基于协议开发，又不要过早把所有固件内部实现冻结成公开 API。

## 稳定性等级

### Stable

**Stable** 表示：

- 已经属于公开 AhaKey 协议面的一部分
- 允许第三方客户端依赖
- 除非有明确文档说明，否则预期会保持兼容

Stable **不代表永远不会变化**。  
它代表的是：变化应该谨慎、可记录、并被当作兼容性敏感事项处理。

### Experimental

**Experimental** 表示：

- 已经公开到足够让社区实验和接入
- 适合早期尝试者和高级工具使用
- 随着固件和工具链演进，更可能发生变化

Experimental 能力可以使用，但应谨慎依赖。  
它们是公开的，但还不属于长期稳定承诺。

### Internal

**Internal** 表示：

- 属于实现细节
- 不属于公开兼容性契约
- 可能在没有公开兼容承诺的前提下变化

第三方工具应尽量避免依赖 internal 细节。

---

## 当前 Stable 协议面

以下内容目前被视为 **Stable**：

### Stable 的传输与命令通路
- 自定义服务 `0x7340`
- `0x7343` 命令写入通道
- `0x7344` 通知 / 回包通道

### Stable 的命令能力
- `0x00` 状态查询 / 状态返回
- `0x04` 保存配置
- `0x73` 按键配置容器
- `0x83` 图片元数据查询
- `0x90` Claude 状态同步

### Stable 的状态返回字段
当前状态帧中，以下字段位置和含义被视为稳定公共协议的一部分：

- battery
- firmware main version
- firmware sub version
- mode
- light
- switch state
- reserved 字段位置

其中部分字段的业务语义未来仍可能继续补充，但状态帧本身已经属于公开协议契约。

---

## 当前 Experimental 协议面

以下内容目前被视为 **Experimental**：

- `0x80` 图片 / flash 写入初始化
- `0x7341` 上的原始大数据传输
- `0x82` 图片元数据更新
- `0x01` 设备名修改
- `0x02` Appearance 修改

这些能力已经足够公开文档化，但暂时不建议作为长期稳定集成目标。

---

## 当前 Internal 区域

以下内容目前被视为 **Internal**：

- flash 地址和存储布局
- 图片传输过程中的临时字段
- 图片写入进度的内部实现细节
- OLED 内部渲染逻辑
- WS2812 的具体底层实现
- 不准备作为客户端控制目标的 mode 内部语义
- 不属于公开返回帧的运行时内部字段

---

## 如何使用这份策略

如果你在开发第三方客户端：

### 可以放心依赖
- Stable 的传输路径
- Stable 的命令能力
- Stable 的状态返回字段

### 需要谨慎使用
- Experimental 的图片写入与大数据流程
- Experimental 的元数据修改类命令

### 尽量不要依赖
- Internal 的运行时和存储细节
- 没有文档说明的副作用
- 标记为 internal 或 “待确认” 的行为

---

## 协议变更应该如何记录

当协议发生变化时，理想情况下应该记录：

- 这次变更影响的是 Stable、Experimental 还是 Internal
- 是否保持兼容
- 是否需要客户端更新
- 旧行为是废弃还是移除

Stable 区域的变更应该比 Internal 区域更谨慎地记录。

---

## 设计原则

AhaKey 不希望把所有固件内部实现都直接暴露为公开 API。

公开协议应该描述的是 **产品行为**，而不是每一个内部机制。

例如：

### 适合作为公开协议的
- 查询当前状态
- 更新 Claude 状态
- 配置某个 mode 下的按键
- 查询图片槽位元数据

### 通常不适合作为公开协议的
- 原始 flash 地址管理
- 传输过程中的临时计数器
- 没有文档说明的渲染内部逻辑
