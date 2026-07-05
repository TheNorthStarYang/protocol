[English](#english) | [简体中文](#简体中文)

---

# English

## Events and States

This document describes the public state-return model and public state-related concepts in the AhaKey protocol.

At the current documentation stage, the most important public state flow is the state query / state return command pair centered around command `0x00`.

---

## Public state query flow

A host-side client may query current device-visible state by sending command `0x00` through the command path.

The device then returns a state frame through the notify / response path.

### Current public transport expectation
- host sends state query on Char3 `0x7343`
- device returns state information on Char4 `0x7344`

---

## Current public state-return frame

The current confirmed state-return frame uses the following structure:

| Byte position | Meaning |
|---|---|
| `0` | `0xAA` |
| `1` | `0xBB` |
| `2` | Command ID = `0x00` |
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

---

## Field meanings

### Battery
Current battery level field returned by the device.

### Signal
Currently returned as a public field in the state frame.

At the current documentation stage, this field is treated as a returned observation field.

### Firmware main version
Current major firmware version field in the state frame.

### Firmware sub version
Current minor firmware version field in the state frame.

### Mode
Current device mode as exposed through the public state frame.

This field is stable as a returned state field.

However, not every internal mode value should be assumed to be user-configurable.

### Light
Current light-related state as exposed through the public state frame.

This field is currently treated as a returned state field.  
It should not yet be assumed to be a general-purpose public light-control API.

### Switch state
Current switch position as exposed through the public state frame.

Current public interpretation:

- `0` = up
- `1` = down
- `2` = middle

This is one of the most useful public runtime state fields for third-party workflow tools.

### Reserved
Reserved public field position.

Clients should preserve tolerance for future meaning here.

---

## Public event-related concepts

At the public protocol level, the following state-related concepts are currently meaningful for third-party clients:

- current mode
- current light state
- current switch state
- current firmware version
- current battery state
- current Claude-related synchronized state

These concepts are useful even when the lower-level firmware event model is more complex internally.

---

## Claude-related public state

The codebase also indicates public-facing Claude-related state concepts used through command `0x90`.

These include values corresponding to higher-level workflow phases such as:

- notification
- permission request
- pre-tool-use
- post-tool-use
- session start
- stop
- task completed
- user prompt submit
- session end

At the protocol level, these should be understood as **high-level synced state values**, not raw BLE transport events.

---

## Public state vs internal runtime details

A few rules are important here:

### Public state
These are safe to document and observe as part of the protocol:
- battery
- firmware version
- mode
- light
- switch state
- Claude state synchronization values

### Internal runtime details
These should not be treated as stable public state:
- temporary write progress
- internal transfer addresses
- storage cursor details
- internal rendering progress

---

## Event model boundary

The codebase contains many internal application / TMOS / GAP / GATT events.

Those internal events are important for firmware implementation, but they are **not automatically part of the public protocol contract**.

For public third-party client development, the most important event-facing behavior is:

- command is sent
- device returns a frame or notify
- host interprets the returned public state

---

## Client recommendations

When reading state frames:

- validate the frame header and tail
- check the command ID
- parse fields by fixed position
- avoid assuming undocumented meanings
- tolerate reserved fields
- treat undocumented values conservatively

---

## Confirmed

- `0x00` is the public state query / state return command ID
- the returned frame includes battery, signal, firmware version, mode, light, switch state, and reserved position
- switch state is currently interpreted as up / down / middle
- Claude-related workflow state values exist as public synchronized concepts

## High-probability interpretation

- the state-return frame is the main public device runtime snapshot for third-party clients
- light is currently better treated as observed state than as a stable writable control target
- mode values beyond user-facing configuration ranges may still include internal meaning

## To be confirmed

- whether additional state-return variants exist in future revisions
- whether more detailed public event notifications will be documented later
- whether any currently reserved field gains public meaning in a future version

---

# 简体中文

## 事件与状态

这份文档说明 AhaKey 协议中的公开状态返回模型，以及和状态相关的公共概念。

在当前文档阶段，最重要的公开状态流程是围绕 `0x00` 命令展开的状态查询 / 状态返回。

---

## 公开状态查询流程

主机侧客户端可以通过命令 `0x00` 查询设备当前对外可见状态。

设备随后会通过通知 / 回包通道返回状态帧。

### 当前公开传输方式
- 主机通过 Char3 `0x7343` 发送状态查询
- 设备通过 Char4 `0x7344` 返回状态信息

---

## 当前公开状态返回帧

当前已确认的状态返回帧结构如下：

| 字节位置 | 含义 |
|---|---|
| `0` | `0xAA` |
| `1` | `0xBB` |
| `2` | 命令 ID = `0x00` |
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

---

## 字段说明

### Battery
设备返回的当前电量字段。

### Signal
当前状态帧里返回的 signal 字段。

在当前文档阶段，这个字段被视为对外返回的观察值。

### Firmware main version
状态帧中的固件主版本字段。

### Firmware sub version
状态帧中的固件次版本字段。

### Mode
状态帧对外暴露的当前模式字段。

这个字段作为返回状态字段是稳定的。  
但不是所有内部 mode 值都应该被默认理解为用户可配置模式。

### Light
状态帧中对外暴露的当前灯效/灯态字段。

这个字段当前被视为返回状态字段。  
它目前不应被默认理解为一个通用可写的公开灯效控制 API。

### Switch state
状态帧中对外暴露的当前拨杆状态字段。

当前公开解释为：

- `0` = up
- `1` = down
- `2` = middle

这是第三方工作流客户端最有价值的公开运行态字段之一。

### Reserved
保留字段位置。

客户端应对未来版本可能赋予它新含义保持兼容性。

---

## 公开状态相关概念

在公开协议层面，目前对第三方客户端有意义的状态概念包括：

- 当前 mode
- 当前 light 状态
- 当前 switch 状态
- 当前 firmware version
- 当前 battery 状态
- 当前 Claude 相关同步状态

即使底层固件内部事件模型更复杂，这些概念对第三方开发已经足够有用。

---

## Claude 相关公开状态

代码中还表明，命令 `0x90` 用于同步 Claude 相关的高层工作流状态。

这些状态包括：

- notification
- permission request
- pre-tool-use
- post-tool-use
- session start
- stop
- task completed
- user prompt submit
- session end

在协议层面，这些更适合理解为**高层同步状态值**，而不是 BLE 原始底层事件。

---

## 公开状态与内部运行态的边界

这里有几个重要规则：

### 公开状态
以下内容适合被当作协议公开状态：
- battery
- firmware version
- mode
- light
- switch state
- Claude 状态同步值

### 内部运行态
以下内容不应被当作稳定公开状态：
- 临时写入进度
- 内部传输地址
- 存储游标细节
- 内部渲染进度

---

## 事件模型边界

代码里存在很多内部应用 / TMOS / GAP / GATT 事件。

这些事件对固件实现很重要，但**并不自动属于公开协议契约**。

对于第三方客户端开发来说，最重要的公开事件行为是：

- 主机发出命令
- 设备返回帧或 notify
- 主机解析公开状态

---

## 客户端建议

在读取状态帧时，建议：

- 校验帧头和帧尾
- 检查命令 ID
- 按固定位置解析字段
- 不要默认给未文档化字段强加语义
- 对 reserved 字段保持兼容
- 对未说明的取值保持保守处理

---

## 已确认

- `0x00` 是公开的状态查询 / 状态返回命令 ID
- 返回帧包含 battery、signal、firmware version、mode、light、switch state 和 reserved 字段位置
- switch state 当前可解释为 up / down / middle
- Claude 相关工作流状态值作为公开同步概念存在

## 高概率理解

- 状态返回帧是第三方客户端最重要的设备运行态快照
- light 当前更适合作为状态观察值，而不是稳定可写控制目标
- 某些 mode 值可能包含用户配置范围之外的内部语义

## 待确认

- 未来版本是否会增加新的状态返回帧变体
- 是否会在后续版本中补充更多公开事件通知
- 目前 reserved 字段是否会在未来获得公开含义
