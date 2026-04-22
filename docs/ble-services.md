[English](#english) | [简体中文](#简体中文)

---

# English

## BLE Services and Characteristics

This document describes the public BLE surfaces relevant to AhaKey protocol development.

AhaKey devices expose both standard BLE/HID-related services and an AhaKey-specific custom BLE channel.

For third-party client development, the custom BLE channel is the primary focus.

---

## Public integration focus

If you are building a third-party client, the most important BLE surface is:

- Service `0x7340`
- Char1 `0x7341`
- Char3 `0x7343`
- Char4 `0x7344`

Standard HID, Battery, Device Information, and other standard services may still exist on the device, but they are not the main protocol surface for AhaKey custom client integration.

---

## AhaKey custom service

### Service `0x7340`

This is the current custom BLE service used by AhaKey host-side tools and protocol commands.

### Characteristic summary

| Characteristic | UUID | Direction | Public role | Current status |
|---|---|---|---|---|
| Char1 | `0x7341` | Host → Device | Bulk payload path | Experimental |
| Char3 | `0x7343` | Host → Device | Command write path | Stable |
| Char4 | `0x7344` | Device → Host | Notify / response path | Stable |

---

## Characteristic details

### Char1 `0x7341`

**Role:** bulk payload path

This characteristic is used for raw payload transfer in flows that need larger data movement, such as image-related transfer.

#### Recommended interpretation
- Do **not** treat Char1 as the general command path.
- Use Char1 only in flows explicitly documented as bulk-transfer flows.
- In the current public documentation stage, Char1 is treated as **Experimental**.

#### Why it is not Stable yet
The high-level entry flow is visible, but low-level transfer and storage details are still too close to firmware implementation details.

---

### Char3 `0x7343`

**Role:** command write path

This characteristic is the main host-side entry point for public AhaKey protocol commands.

Typical commands written here include:

- `0x00` — state query
- `0x04` — save configuration
- `0x73` — key configuration container
- `0x83` — image metadata query
- `0x90` — Claude state synchronization

#### Recommended use
- send one command frame at a time
- wait for the response on Char4
- then send the next command

Char3 is currently part of the **Stable** public protocol surface.

---

### Char4 `0x7344`

**Role:** notify / response path

This characteristic is used by the device to send responses and notifications back to the host.

Typical uses include:

- ACK frames
- state return frames
- query results
- completion notifications

#### Recommended use
A third-party client should enable notifications on Char4 before sending command frames through Char3.

Char4 is currently part of the **Stable** public protocol surface.

---

## Standard BLE/HID-related services

The codebase also indicates the existence of standard BLE/HID-related services, including areas such as:

- HID Service
- Battery Service
- Scan Parameters Service
- Device Information Service
- GAP / GATT-related built-in services

These services may be important for full device behavior, but they are **not the main AhaKey custom protocol entry point**.

At the current documentation stage, this repository does not attempt to fully re-document all standard BLE service behavior.

---

## Minimal client connection flow

The recommended minimal BLE flow for a third-party AhaKey client is:

1. scan for the device
2. connect
3. discover service `0x7340`
4. discover characteristics `0x7341`, `0x7343`, `0x7344`
5. enable notify on `0x7344`
6. send a command frame to `0x7343`
7. wait for the response on `0x7344`
8. only use `0x7341` when a documented bulk-transfer flow requires it

---

## Stability summary

### Stable
- Service `0x7340`
- Char3 `0x7343` as command path
- Char4 `0x7344` as notify / response path

### Experimental
- Char1 `0x7341` as bulk-transfer path

### Internal / not guaranteed
- low-level transfer internals
- storage layout assumptions
- undocumented side effects tied to firmware implementation

---

## Confirmed

- Service `0x7340` is the AhaKey custom service
- Char1 = `0x7341`
- Char3 = `0x7343`
- Char4 = `0x7344`
- Char3 is used for command writes
- Char4 is used for notify / response behavior
- Char1 is used for bulk payload flow

## High-probability interpretation

- Third-party clients should treat `0x7343` + `0x7344` as the main stable command/response pair
- `0x7341` should be reserved for larger payload flows such as image-related transfer

## To be confirmed

- whether any future firmware revision adds additional public custom characteristics
- whether any bulk-transfer flow gains stronger stability guarantees in future protocol versions

---

# 简体中文

## BLE 服务与特征

这份文档说明 AhaKey 协议开发中最相关的 BLE 接口。

AhaKey 设备同时暴露了标准 BLE / HID 相关服务，以及 AhaKey 自定义 BLE 通道。

对于第三方客户端开发来说，重点是 AhaKey 的自定义 BLE 通道。

---

## 公开接入重点

如果你在开发第三方客户端，最重要的 BLE 接口是：

- Service `0x7340`
- Char1 `0x7341`
- Char3 `0x7343`
- Char4 `0x7344`

设备上可能还存在 HID、Battery、Device Information 等标准服务，但它们不是 AhaKey 自定义客户端协议的主要接入面。

---

## AhaKey 自定义服务

### Service `0x7340`

这是当前 AhaKey 主机侧工具和协议命令使用的自定义 BLE 服务。

### Characteristic 总览

| Characteristic | UUID | 方向 | 对外角色 | 当前状态 |
|---|---|---|---|---|
| Char1 | `0x7341` | 主机 → 设备 | 大数据正文通道 | Experimental |
| Char3 | `0x7343` | 主机 → 设备 | 命令写入通道 | Stable |
| Char4 | `0x7344` | 设备 → 主机 | 通知 / 回包通道 | Stable |

---

## Characteristic 详细说明

### Char1 `0x7341`

**角色：** 大数据正文通道

这个 characteristic 用于需要较大数据传输的流程，例如图片相关传输。

#### 推荐理解
- 不要把 Char1 当作通用命令通道。
- 只有在文档明确说明属于大数据传输流程时，才使用 Char1。
- 在当前公开文档阶段，Char1 被视为 **Experimental**。

#### 为什么暂时不是 Stable
虽然高层流程已经可以识别出来，但更底层的传输与存储细节仍然和固件内部实现耦合较强。

---

### Char3 `0x7343`

**角色：** 命令写入通道

这个 characteristic 是主机侧发送 AhaKey 公共协议命令的主要入口。

典型写入命令包括：

- `0x00` — 状态查询
- `0x04` — 保存配置
- `0x73` — 按键配置容器
- `0x83` — 图片元数据查询
- `0x90` — Claude 状态同步

#### 推荐使用方式
- 一次只发送一条命令帧
- 等待 Char4 的回包
- 再发送下一条命令

Char3 当前属于 **Stable** 公开协议面的一部分。

---

### Char4 `0x7344`

**角色：** 通知 / 回包通道

这个 characteristic 用于设备向主机发送响应和通知。

典型用途包括：

- ACK 回包
- 状态返回帧
- 查询结果
- 完成通知

#### 推荐使用方式
第三方客户端应先打开 Char4 的 notify，再通过 Char3 发送命令。

Char4 当前属于 **Stable** 公开协议面的一部分。

---

## 标准 BLE / HID 相关服务

代码中也表明设备存在标准 BLE / HID 相关服务，例如：

- HID Service
- Battery Service
- Scan Parameters Service
- Device Information Service
- GAP / GATT 内建服务

这些服务对设备整体行为可能重要，但**不是 AhaKey 自定义协议的主要入口**。

在当前文档阶段，这个仓库不打算完整重写所有标准 BLE 服务说明。

---

## 最小客户端连接流程

第三方 AhaKey 客户端推荐采用下面的最小 BLE 流程：

1. 扫描设备
2. 建立连接
3. 发现服务 `0x7340`
4. 发现 `0x7341`、`0x7343`、`0x7344`
5. 打开 `0x7344` 的 notify
6. 向 `0x7343` 写入命令帧
7. 在 `0x7344` 等待回包
8. 只有在文档明确说明需要大数据传输时，才使用 `0x7341`

---

## 稳定性摘要

### Stable
- Service `0x7340`
- Char3 `0x7343` 作为命令通道
- Char4 `0x7344` 作为通知 / 回包通道

### Experimental
- Char1 `0x7341` 作为大数据传输通道

### Internal / 不保证公开
- 更底层的传输内部逻辑
- 存储布局假设
- 与固件实现强耦合的未文档化副作用

---

## 已确认

- `0x7340` 是 AhaKey 自定义服务
- Char1 = `0x7341`
- Char3 = `0x7343`
- Char4 = `0x7344`
- Char3 用于命令写入
- Char4 用于通知 / 回包
- Char1 用于大数据通路

## 高概率理解

- 第三方客户端应把 `0x7343` + `0x7344` 视为主要的稳定命令 / 回包对
- `0x7341` 更适合保留给图片等大数据流程

## 待确认

- 未来固件版本是否会增加新的公开 custom characteristic
- 某些大数据传输流程是否会在未来升级为 Stable
