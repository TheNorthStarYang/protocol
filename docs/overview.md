[English](#english) | [简体中文](#简体中文)

---

# English

## Protocol Overview

This document gives a high-level view of how the AhaKey public protocol is organized and how third-party clients should interact with it.

## Scope

AhaKey devices expose both standard BLE/HID-related services and an AhaKey-specific custom BLE channel.

For community-built clients, the custom BLE channel is the primary integration surface.

This document focuses on that public custom channel.

## Main custom BLE channel

The current custom channel is centered around:

- Service `0x7340`
- Char1 `0x7341`
- Char3 `0x7343`
- Char4 `0x7344`

### Role of each characteristic

#### Char1 `0x7341`
Bulk payload path.

This path is mainly used for raw payload transfer in documented flows such as image-related transfer.

#### Char3 `0x7343`
Command path.

This is the main write entry point for host-side control commands.

#### Char4 `0x7344`
Notify / response path.

This path is used for ACK frames, state return frames, query results, and completion notifications.

## Public framing model

The public custom command flow uses framed command packets.

Current confirmed frame boundaries:

- header: `AA BB`
- tail: `CC DD`

At the current documentation stage:

- no confirmed public length field
- no confirmed public checksum field

If those appear later in new revisions, they should be documented explicitly rather than assumed.

## Main interaction model

A typical third-party client should work like this:

1. scan for the device
2. connect to the device
3. discover service `0x7340`
4. enable notifications on `0x7344`
5. send commands to `0x7343`
6. wait for notify responses on `0x7344`
7. use `0x7341` only when a documented bulk-transfer flow requires it

## Important practical rule

For command-driven interaction, the safest current assumption is:

- send one command frame at a time
- wait for the notify response
- then send the next command

Do not assume that multiple concatenated command frames in a single write will be handled correctly.

## Public protocol categories

At a high level, the public protocol currently includes these categories:

### State query and state return
Used to read current device-visible runtime state.

### Configuration commands
Used to update configurable behavior such as key-related settings.

### Claude state synchronization
Used to notify the device about high-level Claude workflow state.

### Image-related flows
Used for image metadata query and, experimentally, bulk image transfer.

## Current stable entry points

The most important stable entry points for third-party clients are:

- `0x00` — state query / state return
- `0x04` — save configuration
- `0x73` — key configuration container
- `0x83` — image metadata query
- `0x90` — Claude state synchronization

## State frame overview

The current public state return frame includes these high-level fields:

- battery
- signal
- firmware main version
- firmware sub version
- mode
- light
- switch state
- reserve

Some field meanings may still be refined in the detailed docs, but the frame shape itself is already part of the public protocol surface.

## Public vs internal boundary

A key rule of the AhaKey protocol is:

**Public docs describe product behavior.  
They do not promise every internal firmware mechanism.**

That means:

### public
- command entry points
- returned frame structure
- stable state meanings
- documented configuration flows

### not guaranteed public
- flash address management
- internal progress variables
- undocumented rendering internals
- implementation-specific storage logic

## When to read the next documents

After this overview, continue with:

1. `stability-policy.md` — to understand what is stable
2. `ble-services.md` — to understand the actual BLE channel
3. `events-and-states.md` — to understand returned frames and state values
4. `commands.md` — to understand command-level behavior

---

# 简体中文

## 协议总览

这份文档从高层说明 AhaKey 公开协议是如何组织的，以及第三方客户端应该如何与它交互。

## 范围

AhaKey 设备同时暴露了标准 BLE / HID 相关服务，以及 AhaKey 自定义 BLE 通道。

对于社区客户端来说，自定义 BLE 通道才是最主要的接入面。

这份文档聚焦的就是这个公开的自定义通道。

## 自定义 BLE 主通道

当前自定义主通道围绕以下内容展开：

- Service `0x7340`
- Char1 `0x7341`
- Char3 `0x7343`
- Char4 `0x7344`

### 每个 characteristic 的角色

#### Char1 `0x7341`
大数据正文通道。

它主要用于在文档明确说明的场景中传输原始大数据，例如图片相关传输流程。

#### Char3 `0x7343`
命令通道。

这是主机侧控制命令的主要写入口。

#### Char4 `0x7344`
通知 / 回包通道。

它用于发送 ACK、状态返回、查询结果以及完成通知。

## 公开帧模型

当前自定义命令流使用有边界的帧格式。

目前已经确认的帧边界是：

- 帧头：`AA BB`
- 帧尾：`CC DD`

在当前文档阶段：

- 还没有确认的公开长度字段
- 还没有确认的公开校验字段

如果未来协议修订中出现这些字段，应在文档中明确写出，而不是假设存在。

## 主要交互模型

一个典型的第三方客户端应该按下面的方式工作：

1. 扫描设备
2. 连接设备
3. 发现服务 `0x7340`
4. 打开 `0x7344` 的 notify
5. 向 `0x7343` 发送命令
6. 在 `0x7344` 上等待回包
7. 只有在文档明确说明需要大数据传输时，才使用 `0x7341`

## 一个重要的实践规则

对于命令驱动型交互，当前最安全的假设是：

- 一次只发送一条命令帧
- 等待 notify 回包
- 再发送下一条命令

不要假设把多条命令拼在一次写入里也能被正确处理。

## 当前公开协议的大类

从高层看，当前公开协议主要包含这些类型：

### 状态查询与状态返回
用于读取设备当前对外可见的运行状态。

### 配置类命令
用于修改可配置行为，例如按键相关设置。

### Claude 状态同步
用于把高层 Claude 工作流状态同步给设备。

### 图片相关流程
用于查询图片元数据，以及实验性的图片大数据传输。

## 当前稳定入口

对第三方客户端最重要的稳定入口包括：

- `0x00` — 状态查询 / 状态返回
- `0x04` — 保存配置
- `0x73` — 按键配置容器
- `0x83` — 图片元数据查询
- `0x90` — Claude 状态同步

## 状态帧总览

当前公开的状态返回帧包含以下高层字段：

- battery
- signal
- firmware main version
- firmware sub version
- mode
- light
- switch state
- reserve

其中部分字段的业务语义还会在详细文档中继续细化，但帧结构本身已经属于公开协议面的一部分。

## 公开与内部的边界

AhaKey 协议有一个重要原则：

**公开文档描述的是产品行为。  
它不会承诺每一个固件内部机制。**

也就是说：

### public
- 命令入口
- 返回帧结构
- 稳定的状态语义
- 已文档化的配置流程

### 不保证公开
- flash 地址管理
- 内部进度变量
- 未文档化的渲染内部逻辑
- 与实现强绑定的存储逻辑

## 下一步建议阅读

看完这份 overview 之后，建议继续阅读：

1. `stability-policy.md` — 先理解哪些是稳定能力
2. `ble-services.md` — 再理解 BLE 通道本身
3. `events-and-states.md` — 再看状态帧和返回值
4. `commands.md` — 最后看命令级行为
