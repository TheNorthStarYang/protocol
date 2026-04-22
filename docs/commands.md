[English](#english) | [简体中文](#简体中文)

---

# English

## Commands

This document describes the current public command surface of the AhaKey custom BLE protocol.

At the current documentation stage, commands are sent through:

- Service `0x7340`
- Char3 `0x7343` as the main command write path
- Char4 `0x7344` as the notify / response path

Some bulk-transfer flows also use Char1 `0x7341`.

---

## Public frame boundary

Current confirmed public frame boundary:

- header: `AA BB`
- tail: `CC DD`

### Current documentation note
At this stage, there is no confirmed public length field and no confirmed public checksum field in the general command framing model.

Clients should not assume hidden checksum or length semantics unless later documentation explicitly adds them.

---

## Command status categories

This document uses these stability labels:

- **Stable**
- **Experimental**
- **Internal / not public**

---

## `0x00` — State query / state return

**Status:** Stable

### Purpose
Query current device-visible runtime state.

### Direction
- request: Host → Device
- response: Device → Host

### Transport
- request on Char3 `0x7343`
- response on Char4 `0x7344`

### Public response frame
The current confirmed state-return frame is:

| Byte position | Meaning |
|---|---|
| `0` | `0xAA` |
| `1` | `0xBB` |
| `2` | `0x00` |
| `3` | Battery |
| `4` | Signal |
| `5` | Firmware main version |
| `6` | Firmware sub version |
| `7` | Mode |
| `8` | Light |
| `9` | Switch state |
| `10` | Reserved |
| `11` | `0xCC` |
| `12` | `0xDD` |

### Notes
- switch state currently maps to up / down / middle
- light is currently documented as a returned state field, not a stable writable API
- mode is stable as a returned field, but not every internal value should be assumed to be public configuration space

---

## `0x04` — Save configuration

**Status:** Stable

### Purpose
Persist currently modified configuration data.

### Direction
- request: Host → Device
- response: Device → Host

### Notes
This command is important after configuration-changing flows.

At the current documentation stage, it is treated as the stable “commit / persist” step for configuration changes.

---

## `0x73` — Key configuration container

**Status:** Stable

### Purpose
This command family is used for key-related configuration flows.

### Direction
- request: Host → Device
- response: Device → Host

### Public subtypes

| Subtype | Meaning | Current status |
|---|---|---|
| `0x73` | key binding / macro-like content | Stable |
| `0x74` | old key mode binding path | Experimental |
| `0x75` | key description string | Stable |

### Public interpretation
At a product level, this command family is used for:

- configuring key behavior
- updating key-associated content
- updating key description text

### Notes
Third-party clients should treat this as a high-level configuration container rather than relying on internal array or storage layout assumptions.

If a workflow changes key configuration, a save step through `0x04` is recommended.

---

## `0x80` — Image / bulk write initialization

**Status:** Experimental

### Purpose
Initialize an image-related or bulk-write flow.

### Direction
- request: Host → Device
- subsequent payload flow may continue through Char1 `0x7341`

### Notes
This command is currently documented as part of the public protocol surface, but only as **Experimental**.

Clients should not assume long-term stability for:
- raw storage behavior
- internal address progression
- flash management details

Use only if you intentionally target experimental image transfer flows.

---

## `0x82` — Image metadata update

**Status:** Experimental

### Purpose
Update image-related metadata.

### Direction
- request: Host → Device
- response behavior depends on flow

### Notes
This command is public enough to document, but not yet recommended as a stable long-term integration target.

---

## `0x83` — Image metadata query

**Status:** Stable

### Purpose
Query image-related metadata visible through the public protocol.

### Direction
- request: Host → Device
- response: Device → Host

### Notes
This command is the preferred stable entry point for image-related querying.

Compared with raw image transfer flows, metadata query is much safer to treat as part of the stable public protocol.

---

## `0x90` — Claude state synchronization

**Status:** Stable

### Purpose
Sync a high-level Claude workflow state to the device.

### Direction
- request: Host → Device

### Public state concepts
Known public Claude-related concepts include values corresponding to:

- notification
- permission request
- pre-tool-use
- post-tool-use
- session start
- stop
- task completed
- user prompt submit
- session end

### Notes
This command is best understood as a high-level workflow-state update, not as a generic transport for arbitrary internal state.

---

## `0x01` — Device name update

**Status:** Experimental

### Purpose
Update device name-related configuration.

### Notes
At the current documentation stage, persistence behavior is not yet strong enough to recommend this as a stable public integration target.

---

## `0x02` — Appearance update

**Status:** Experimental

### Purpose
Update appearance-related configuration.

### Notes
At the current documentation stage, persistence behavior is not yet strong enough to recommend this as a stable public integration target.

---

## `0x03` — Reset branch

**Status:** Internal / not public

### Notes
A branch exists in code, but it is not currently treated as a public command capability.

Third-party clients should not depend on it.

---

## General client recommendations

When sending commands:

- use Char3 for command frames
- enable notify on Char4 before command exchange
- send one command at a time
- wait for the response before sending the next command
- treat image/bulk flows separately from normal command flows

---

## Confirmed

- `0x00`, `0x04`, `0x73`, `0x80`, `0x82`, `0x83`, `0x90` are present in the current command surface
- `0x00` is the state query / state return entry
- `0x04` is used as a configuration save step
- `0x73` is a configuration container with known subtypes
- `0x83` is used for image metadata query
- `0x90` is used for Claude state synchronization

## High-probability interpretation

- `0x04` should be treated as the normal persistence step after configuration changes
- `0x73` should be treated as a product-level key configuration family, not as a raw storage structure
- `0x80` + Char1 together represent an experimental bulk image transfer path

## To be confirmed

- exact payload definitions for every configuration subtype
- whether future protocol versions add stronger guarantees for bulk transfer flows
- whether `0x01` and `0x02` will become stable in future revisions

---

# 简体中文

## 命令说明

这份文档说明 AhaKey 自定义 BLE 协议当前公开的命令面。

在当前文档阶段，命令主要通过以下路径发送：

- Service `0x7340`
- Char3 `0x7343` 作为主命令写入通道
- Char4 `0x7344` 作为通知 / 回包通道

部分大数据流程还会使用 Char1 `0x7341`。

---

## 公开帧边界

当前已确认的公开帧边界为：

- 帧头：`AA BB`
- 帧尾：`CC DD`

### 当前文档说明
在当前阶段，尚未确认通用命令帧模型里存在公开长度字段，也尚未确认存在公开校验字段。

除非后续文档明确补充，否则客户端不应假设存在隐藏的长度或校验语义。

---

## 命令状态分类

本文件使用以下稳定性标签：

- **Stable**
- **Experimental**
- **Internal / not public**

---

## `0x00` — 状态查询 / 状态返回

**状态：** Stable

### 作用
查询设备当前对外可见的运行状态。

### 方向
- 请求：主机 → 设备
- 返回：设备 → 主机

### 传输路径
- 请求走 Char3 `0x7343`
- 返回走 Char4 `0x7344`

### 当前公开返回帧
当前已确认的状态返回帧如下：

| 字节位置 | 含义 |
|---|---|
| `0` | `0xAA` |
| `1` | `0xBB` |
| `2` | `0x00` |
| `3` | Battery |
| `4` | Signal |
| `5` | Firmware main version |
| `6` | Firmware sub version |
| `7` | Mode |
| `8` | Light |
| `9` | Switch state |
| `10` | Reserved |
| `11` | `0xCC` |
| `12` | `0xDD` |

### 说明
- switch state 当前可映射为 up / down / middle
- light 当前被记录为返回状态字段，而不是稳定可写控制 API
- mode 作为返回字段是稳定的，但不是所有内部值都应被当作公开配置空间

---

## `0x04` — 保存配置

**状态：** Stable

### 作用
将当前已经修改的配置持久化保存。

### 方向
- 请求：主机 → 设备
- 返回：设备 → 主机

### 说明
这个命令在配置修改类流程之后很重要。

在当前文档阶段，它被视为稳定的“提交 / 保存”步骤。

---

## `0x73` — 按键配置容器

**状态：** Stable

### 作用
这个命令族用于按键相关配置流程。

### 方向
- 请求：主机 → 设备
- 返回：设备 → 主机

### 当前公开子类型

| 子类型 | 含义 | 当前状态 |
|---|---|---|
| `0x73` | 按键绑定 / 宏内容 | Stable |
| `0x74` | 旧键模式绑定路径 | Experimental |
| `0x75` | 按键描述字符串 | Stable |

### 对外理解
在产品层面，这个命令族主要用于：

- 配置按键行为
- 更新按键关联内容
- 更新按键描述文本

### 说明
第三方客户端应把它当成高层配置容器，而不是依赖内部数组或存储布局。

如果某个流程修改了按键配置，建议随后通过 `0x04` 进行保存。

---

## `0x80` — 图片 / 大数据写入初始化

**状态：** Experimental

### 作用
初始化图片相关或大数据写入流程。

### 方向
- 请求：主机 → 设备
- 后续数据正文可能继续通过 Char1 `0x7341` 发送

### 说明
这个命令目前被纳入公开协议文档，但仅作为 **Experimental**。

客户端不应依赖以下内容的长期稳定性：

- 原始存储行为
- 内部地址推进逻辑
- flash 管理细节

只有在你明确要支持实验性图片传输流程时，才建议使用。

---

## `0x82` — 图片元数据更新

**状态：** Experimental

### 作用
更新图片相关元数据。

### 方向
- 请求：主机 → 设备
- 返回行为依赖具体流程

### 说明
这个命令已经足够公开文档化，但暂时不建议作为长期稳定集成目标。

---

## `0x83` — 图片元数据查询

**状态：** Stable

### 作用
查询公开协议层可见的图片元数据。

### 方向
- 请求：主机 → 设备
- 返回：设备 → 主机

### 说明
这个命令是图片相关查询的首选稳定入口。

相比原始图片写入流程，把图片元数据查询纳入 Stable 风险更低。

---

## `0x90` — Claude 状态同步

**状态：** Stable

### 作用
向设备同步高层 Claude 工作流状态。

### 方向
- 请求：主机 → 设备

### 当前公开状态概念
目前已知的 Claude 相关公开概念包括：

- notification
- permission request
- pre-tool-use
- post-tool-use
- session start
- stop
- task completed
- user prompt submit
- session end

### 说明
这个命令更适合理解为“高层工作流状态更新”，而不是一个通用的任意内部状态传输接口。

---

## `0x01` — 修改设备名

**状态：** Experimental

### 作用
更新设备名相关配置。

### 说明
在当前文档阶段，这个能力的持久化行为还不够清晰，因此暂时不建议作为稳定公开集成能力。

---

## `0x02` — 修改 Appearance

**状态：** Experimental

### 作用
更新 Appearance 相关配置。

### 说明
在当前文档阶段，这个能力的持久化行为还不够清晰，因此暂时不建议作为稳定公开集成能力。

---

## `0x03` — Reset 分支

**状态：** Internal / not public

### 说明
代码中存在对应分支，但当前不把它视为公开命令能力。

第三方客户端不应依赖它。

---

## 客户端通用建议

在发送命令时，建议：

- 使用 Char3 发送命令帧
- 在命令交互前先打开 Char4 notify
- 一次只发送一条命令
- 等待回包后再发送下一条
- 把图片 / 大数据流程与普通命令流程分开处理

---

## 已确认

- `0x00`、`0x04`、`0x73`、`0x80`、`0x82`、`0x83`、`0x90` 属于当前命令面
- `0x00` 是状态查询 / 状态返回入口
- `0x04` 用于配置保存
- `0x73` 是带有已知子类型的配置容器
- `0x83` 用于图片元数据查询
- `0x90` 用于 Claude 状态同步

## 高概率理解

- `0x04` 可以视为配置修改后的常规持久化步骤
- `0x73` 应被视为产品层按键配置族，而不是原始存储结构
- `0x80` + Char1 一起构成实验性的大数据图片传输路径

## 待确认

- 各配置子类型更精确的 payload 定义
- 未来协议版本是否会为大数据传输流程提供更强的稳定性承诺
- `0x01` 和 `0x02` 是否会在未来升级为 Stable
