[English](#english) | [简体中文](#简体中文)

---

# English

## Minimal Client Flow

This document describes the recommended minimal flow for a third-party AhaKey client.

It is intentionally conservative and focuses on the stable public path.

---

## Goal

A minimal client should be able to:

- find the device
- connect to it
- discover the AhaKey custom service
- subscribe to the response path
- query current state
- send at least one stable command
- parse a valid response frame

---

## Recommended minimal BLE flow

### 1. Scan for the device

Do **not** assume that the custom service `0x7340` appears in the advertising UUID list.

At the current stage, a client should identify the device using approaches such as:

- device name
- known bonded device list
- previously stored identity
- application-side device selection

### 2. Connect

Establish a BLE connection to the target device.

### 3. Discover service `0x7340`

After connection, discover the custom AhaKey service:

- `0x7340`

### 4. Discover the three important characteristics

Discover:

- `0x7341`
- `0x7343`
- `0x7344`

### 5. Enable notify on `0x7344`

This step is required before normal command exchange.

Without notify enabled on `0x7344`, the host may not receive:

- ACK frames
- state-return frames
- query results
- completion notifications

### 6. Send a minimal stable command

Send the state query command to Char3 `0x7343`:

```text
AA BB 00 CC DD
```

### 7. Wait for the response on `0x7344`

The device should return a state frame on Char4.

The current public state-return shape is:

```text
AA BB 00 batt signal fw_main fw_sub mode light sw reserve CC DD
```

### 8. Parse conservatively

The client should:

- check header and tail
- verify command ID
- parse fields by fixed position
- tolerate unknown or reserved values

---

## Minimal successful session

A minimal successful session looks like this:

1. scan
2. connect
3. discover `0x7340`
4. discover `0x7341` / `0x7343` / `0x7344`
5. enable notify on `0x7344`
6. write `AA BB 00 CC DD` to `0x7343`
7. receive state frame from `0x7344`
8. parse and display state

---

## Recommended command discipline

At the current stage, the safest command discipline is:

- send one command frame at a time
- wait for the response
- then send the next command

Do not assume that concatenating multiple command frames into one write is safe.

---

## Example: query state

### Request
Write to Char3 `0x7343`:

```text
AA BB 00 CC DD
```

### Expected response
Receive on Char4 `0x7344`:

```text
AA BB 00 batt signal fw_main fw_sub mode light sw reserve CC DD
```

### Useful returned fields
A minimal client can immediately surface:

- battery
- firmware version
- mode
- light
- switch state

---

## Example: save configuration

After a documented configuration change, a client may send:

```text
AA BB 04 CC DD
```

At the current stage, this is the stable save / commit step for configuration changes.

---

## Example: Claude state synchronization

A client may send a high-level Claude state update on Char3:

```text
AA BB 90 <state> CC DD
```

This is a stable public command for syncing workflow state to the device.

---

## When to use `0x7341`

Do **not** use `0x7341` in the minimal client flow.

Use Char1 only if you intentionally support experimental bulk-transfer flows such as image-related transfer.

That path should be treated as separate from the minimal stable command path.

---

## Minimal error-handling guidance

A minimal client should handle:

- missing service `0x7340`
- missing notify enable on `0x7344`
- malformed frame header / tail
- unexpected command ID
- timeout waiting for response
- reserved or undocumented field values

When in doubt, fail conservatively and surface logs to the developer.

---

# 简体中文

## 最小客户端接入流程

这份文档描述第三方 AhaKey 客户端推荐采用的最小接入流程。

它是有意偏保守的，重点围绕当前稳定公开路径展开。

---

## 目标

一个最小客户端至少应该能够：

- 找到设备
- 建立连接
- 发现 AhaKey 自定义服务
- 订阅回包通道
- 查询当前状态
- 发送至少一个稳定命令
- 解析合法返回帧

---

## 推荐的最小 BLE 流程

### 1. 扫描设备

不要假设广播 UUID 列表里一定会出现自定义服务 `0x7340`。

在当前阶段，客户端更适合通过以下方式识别设备：

- 设备名
- 已配对设备列表
- 之前保存的设备身份
- 应用侧设备选择逻辑

### 2. 建立连接

与目标设备建立 BLE 连接。

### 3. 发现服务 `0x7340`

连接后，发现 AhaKey 自定义服务：

- `0x7340`

### 4. 发现三个关键 characteristic

发现：

- `0x7341`
- `0x7343`
- `0x7344`

### 5. 打开 `0x7344` 的 notify

这一步是正常命令交互前的必要条件。

如果没有打开 `0x7344` 的 notify，主机可能收不到：

- ACK 回包
- 状态返回帧
- 查询结果
- 完成通知

### 6. 发送一个最小稳定命令

向 Char3 `0x7343` 写入状态查询命令：

```text
AA BB 00 CC DD
```

### 7. 在 `0x7344` 等待返回

设备应该通过 Char4 返回状态帧。

当前公开状态返回结构为：

```text
AA BB 00 batt signal fw_main fw_sub mode light sw reserve CC DD
```

### 8. 保守解析

客户端应当：

- 校验帧头和帧尾
- 校验命令 ID
- 按固定位置解析字段
- 对未知值和 reserved 字段保持兼容

---

## 一个最小成功会话

一个最小成功会话应该是：

1. 扫描
2. 连接
3. 发现 `0x7340`
4. 发现 `0x7341` / `0x7343` / `0x7344`
5. 打开 `0x7344` notify
6. 向 `0x7343` 写入 `AA BB 00 CC DD`
7. 从 `0x7344` 收到状态帧
8. 解析并显示状态

---

## 推荐的命令发送纪律

在当前阶段，最安全的发送方式是：

- 一次只发一条命令帧
- 等到回包
- 再发送下一条命令

不要假设把多条命令拼在同一次写入中是安全的。

---

## 示例：查询状态

### 请求
向 Char3 `0x7343` 写入：

```text
AA BB 00 CC DD
```

### 预期返回
从 Char4 `0x7344` 收到：

```text
AA BB 00 batt signal fw_main fw_sub mode light sw reserve CC DD
```

### 最有价值的返回字段
一个最小客户端可以直接展示：

- battery
- firmware version
- mode
- light
- switch state

---

## 示例：保存配置

在已文档化的配置修改之后，客户端可以发送：

```text
AA BB 04 CC DD
```

在当前阶段，这个命令可以视为配置修改后的稳定保存 / 提交步骤。

---

## 示例：Claude 状态同步

客户端可以通过 Char3 发送高层 Claude 状态同步：

```text
AA BB 90 <state> CC DD
```

这是一个稳定的公开命令，用于把 workflow 状态同步给设备。

---

## 什么时候才使用 `0x7341`

最小客户端流程里**不要**使用 `0x7341`。

只有在你明确要支持实验性大数据流程（例如图片传输）时，才使用 Char1。

这个路径应当和最小稳定命令路径分开处理。

---

## 最小错误处理建议

一个最小客户端至少应处理：

- 找不到服务 `0x7340`
- 没有成功打开 `0x7344` notify
- 帧头 / 帧尾不合法
- 命令 ID 不符合预期
- 等待回包超时
- 返回了 reserved 或未文档化取值

如果不确定，建议保守失败，并把日志暴露给开发者。
