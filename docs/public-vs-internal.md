[English](#english) | [简体中文](#简体中文)

---

# English

## Public vs Internal

This document explains which parts of the AhaKey protocol are intended as public integration surfaces, and which parts should be treated as internal implementation details.

The goal is to help third-party developers build useful clients without depending on firmware internals that may change.

---

## Why this distinction matters

AhaKey is designed as:

- official hardware
- shared BLE protocol
- open software ecosystem

That does **not** mean every internal firmware field or storage behavior should be treated as a public API.

Public protocol documentation should describe **product behavior**.  
It should not freeze every internal implementation detail.

---

## Public protocol surfaces

The following areas are currently part of the public AhaKey protocol surface.

### Public transport surface
- Service `0x7340`
- Char3 `0x7343` as command path
- Char4 `0x7344` as notify / response path

### Public stable commands
- `0x00` — state query / state return
- `0x04` — save configuration
- `0x73` — key configuration container
- `0x83` — image metadata query
- `0x90` — Claude state synchronization

### Public experimental commands
- `0x80` — image / bulk write initialization
- `0x82` — image metadata update
- `0x01` — device name update
- `0x02` — appearance update

### Public returned state fields
The current public returned state frame includes:

- battery
- signal
- firmware main version
- firmware sub version
- mode
- light
- switch state
- reserved field position

---

## Public product behaviors

The following are examples of behaviors that make sense as public protocol contracts:

- query current runtime state
- read current switch position
- inspect current mode
- update Claude workflow state
- configure keys in supported mode/key ranges
- update key description text
- save configuration
- query image metadata

These are visible, useful, product-level behaviors.

---

## Internal implementation details

The following should currently be treated as internal or non-contractual unless later promoted into public documentation.

### Internal transfer and storage details
- flash addresses
- storage layout
- temporary transfer cursors
- write-progress variables
- internal picture write state fields

### Internal rendering and light behavior
- low-level OLED rendering pipeline
- full internal WS2812 implementation details
- undocumented light transition logic
- internal display scheduling

### Internal mode semantics
- meanings of mode values that are not documented as public client-facing configuration spaces
- internal-only mode branches
- implementation-only state transitions

---

## Important example: image transfer

Image-related functionality is a good example of the public/internal boundary.

### Public enough to document
- that `0x80` starts an experimental image-related bulk-write flow
- that bulk data then goes through `0x7341`
- that `0x83` can query image metadata
- that `0x82` updates image metadata

### Not yet stable public contract
- raw flash layout
- exact address progression
- internal write buffering
- rendering internals after storage completes

So the **existence of an image flow** is public,  
but the **firmware storage implementation** is not part of the stable public contract.

---

## Important example: light state

The state frame exposes a `light` field.

That means:

### Public
- clients may read and observe the current light-related state field

### Not automatically public
- arbitrary light scripting
- raw WS2812 frame pushing
- assuming every light value maps to a stable writable API

At the current stage, `light` should be treated as a public returned state field, not as a complete stable lighting-control interface.

---

## Important example: mode values

The state frame exposes `mode`.

That means:

### Public
- clients may read the current mode value
- supported configuration flows may rely on documented mode ranges

### Not automatically public
- every internal mode meaning
- every branch associated with mode values
- assuming all returned modes are valid writable configuration targets

Returned state is public.  
All internal mode semantics are not automatically public.

---

## Safe dependency rules for third-party clients

If you are building a third-party client:

### Safe to depend on
- documented service / characteristic roles
- documented stable commands
- documented response frames
- documented state-field meanings
- documented mode/key configuration limits

### Use carefully
- experimental image transfer flows
- experimental metadata update flows
- commands whose persistence behavior may still evolve

### Avoid depending on
- flash addresses
- internal struct layout
- undocumented side effects
- internal task/event names
- fields explicitly described as internal or “to be confirmed”

---

## Upgrade path

Some currently experimental or internal areas may later become more public if:

- their behavior stabilizes
- their semantics are clear enough at product level
- the team is willing to keep them compatible over time

Until that happens, third-party clients should stay on the documented public surface.

---

# 简体中文

## 公开协议与内部实现边界

这份文档用于说明：AhaKey 协议里哪些部分是公开接入面，哪些部分应该被视为内部实现细节。

目标是让第三方开发者能够开发有用的客户端，同时避免依赖未来可能变化的固件内部机制。

---

## 为什么要区分这两类内容

AhaKey 的定位是：

- 官方硬件
- 共享 BLE 协议
- 开放软件生态

但这**不代表**固件里的每一个字段、每一种存储行为都应该被视为公开 API。

公开协议文档应该描述的是**产品行为**，而不是把所有内部实现都冻结下来。

---

## 当前公开协议面

以下内容目前属于 AhaKey 的公开协议面。

### 公开传输面
- Service `0x7340`
- Char3 `0x7343` 作为命令通道
- Char4 `0x7344` 作为通知 / 回包通道

### 公开 Stable 命令
- `0x00` — 状态查询 / 状态返回
- `0x04` — 保存配置
- `0x73` — 按键配置容器
- `0x83` — 图片元数据查询
- `0x90` — Claude 状态同步

### 公开 Experimental 命令
- `0x80` — 图片 / 大数据写入初始化
- `0x82` — 图片元数据更新
- `0x01` — 修改设备名
- `0x02` — 修改 Appearance

### 公开状态返回字段
当前公开状态帧包含：

- battery
- signal
- firmware main version
- firmware sub version
- mode
- light
- switch state
- reserved 字段位置

---

## 适合作为公开产品行为的内容

以下这些行为适合作为公开协议契约：

- 查询当前运行状态
- 读取当前拨杆位置
- 查看当前 mode
- 更新 Claude 工作流状态
- 在支持的 mode/key 范围内配置按键
- 修改按键描述文本
- 保存配置
- 查询图片元数据

这些都属于可见、可用、产品层的行为。

---

## 当前应视为内部实现的内容

以下内容目前更适合视为 internal 或非契约内容，除非未来明确提升为公开协议。

### 内部传输与存储细节
- flash 地址
- 存储布局
- 临时传输游标
- 写入进度变量
- 图片写入过程中的内部状态字段

### 内部显示与灯效逻辑
- OLED 的底层渲染流程
- WS2812 的完整底层实现
- 未文档化的灯效切换逻辑
- 内部显示调度机制

### 内部 mode 语义
- 没有被文档明确成对外配置空间的 mode 含义
- 只服务于内部实现的 mode 分支
- 仅属于固件运行态的状态切换

---

## 一个重要例子：图片传输

图片相关能力很好地体现了公开与内部的边界。

### 已经足够公开的部分
- `0x80` 会启动一个实验性的图片 / 大数据写入流程
- 后续正文通过 `0x7341` 传输
- `0x83` 可以查询图片元数据
- `0x82` 可以更新图片元数据

### 暂时不属于稳定公开契约的部分
- 原始 flash 布局
- 具体地址推进方式
- 内部写缓存机制
- 数据写入结束后的内部显示逻辑

也就是说，**图片流程的存在**是公开的，  
但**图片如何存进固件内部存储**还不是稳定公开契约。

---

## 一个重要例子：light 字段

状态帧里对外暴露了 `light` 字段。

这意味着：

### 公开的
- 客户端可以读取和观察当前 light 状态字段

### 但不自动代表公开的
- 任意灯效脚本
- 原始 WS2812 帧写入
- 把每一个 light 值都理解成稳定可写 API

在当前阶段，`light` 应被视为公开的返回状态字段，而不是完整稳定的灯效控制接口。

---

## 一个重要例子：mode 字段

状态帧里对外暴露了 `mode`。

这意味着：

### 公开的
- 客户端可以读取当前 mode 值
- 已文档说明的配置流程可以依赖支持的 mode 范围

### 但不自动代表公开的
- 所有内部 mode 语义
- 所有和 mode 相关的固件分支
- 把所有返回 mode 都理解成可写配置目标

返回的 mode 是公开的，  
但所有内部 mode 语义并不自动公开。

---

## 第三方客户端的安全依赖原则

如果你在开发第三方客户端：

### 可以放心依赖
- 已文档化的服务 / characteristic 角色
- 已文档化的 Stable 命令
- 已文档化的返回帧
- 已文档化的状态字段语义
- 已文档化的 mode/key 配置范围

### 需要谨慎使用
- 图片传输等 Experimental 流程
- 元数据修改类 Experimental 命令
- 持久化行为仍可能继续演进的能力

### 尽量不要依赖
- flash 地址
- 内部结构体布局
- 未文档化副作用
- 内部任务 / 事件名称
- 明确标注为 internal 或 “待确认” 的字段

---

## 未来升级路径

有些目前是 experimental 或 internal 的区域，未来可能会升级为更公开的协议能力，前提是：

- 行为足够稳定
- 语义在产品层足够清楚
- 团队愿意长期维护兼容性

在那之前，第三方客户端应尽量停留在已文档化的公开协议面上。
