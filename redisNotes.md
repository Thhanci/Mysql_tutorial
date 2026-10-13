# Redis 学习笔记（完整版：实操记录 + 全知识点补充）

> **说明**：本笔记严格遵循原始目录大纲，保留了所有实操记录与报错解决方案，并对原先缺失的章节进行了通俗易懂的深度补充。

---

## 01. 课程简介

Redis 是目前世界上最流行的 **内存数据库** 之一。本笔记旨在通过“理论+实操”的方式，帮助掌握从基础数据类型到高级分布式架构的核心知识。

---

## 02. Redis 简介

**Redis 是什么？**
- **Re** mote **Di** ctionary **S** erver（远程字典服务器）。
- **基于内存**：读写速度极快（10 万+ QPS）。
- **数据结构丰富**：不只是简单的 KV，还支持列表、集合、哈希等。
- **持久化**：支持将内存数据保存到硬盘。

**为什么快？**
- **纯内存操作**：没有磁盘 IO 的开销。
- **单线程模型**：避免了多线程频繁切换上下文的损耗，也无需担心锁的问题。
- **IO 多路复用**：利用 `epoll` 技术高效处理大量连接。

**可以做什么？**
| 应用场景 | 示例 |
| :--- | :--- |
| **缓存** | 减轻数据库压力，存储热点数据 |
| **排行榜** | 利用 Sorted Set 自动排序 |
| **计数器** | 点赞数、播放量（原子自增） |
| **分布式锁** | 解决多服务器同步问题 |
| **消息队列** | 用 Stream 实现可靠的消息传递 |

---

## 03. 安装配置（实操完整记录）

### 3.1 Windows 安装路径
你的 Redis 安装在：`D:\code\redis\Redis\`
关键文件包括 `redis-server.exe` (服务端)、`redis-cli.exe` (客户端) 和 `redis.conf` (配置文件)。

### 3.2 启动与连接
```cmd
# 启动服务端
cd /d D:\code\redis\Redis
redis-server.exe

# 连接测试
redis-cli ping   # 返回 PONG 表示成功
```

### 3.3 配置问题排查（重要！）
**遇到的问题**：`dump.rdb` 找不到，`CONFIG GET dir` 返回的是 `C:\Windows\System32`。
**原因**：默认工作目录偏差。
**解决方案**：
```redis
# 临时修改
CONFIG SET dir "D:/code/redis/Redis"

# 永久修改：编辑 redis.conf
dir D:/code/redis/Redis
```

### 3.4 Windows CMD 与 Linux 命令对照
| 功能 | Linux/macOS | Windows CMD |
| :--- | :--- | :--- |
| 列出文件 | `ls` | `dir` |
| 复制文件 | `cp` | `copy` |
| 切换目录 | `cd ~` | `cd /d %USERPROFILE%` |
| 查看内容 | `cat` | `type` |

---

## 04. GUI 工具 RedisInsight

**RedisInsight** 是官方推荐的图形化管理工具。
- **可视化操作**：不用背命令，直接点点点就能增删改查。
- **实时监控**：查看内存占用、命令执行频率。
- **Workbench**：支持编写和运行复杂的 Redis 命令。

---

## 05. 字符串 String

- **存取**：`SET key value` / `GET key`
- **自增**：`INCR key` (适合做计数器)
- **批量**：`MSET k1 v1 k2 v2` / `MGET k1 k2`
- **过期**：`SETEX key 10 value` (10 秒后自动过期)

---

## 06. 列表 List

**通俗理解**：一个双向链表，可以从两头插拔数据。
- **添加**：`LPUSH` (左边插) / `RPUSH` (右边插)
- **弹出**：`LPOP` / `RPOP`
- **查看**：`LRANGE key 0 -1` (查看所有元素)
- **长度**：`LLEN key`
- **场景**：最新消息展示、简单的异步队列。

---

## 07. 集合 Set

**通俗理解**：一个无序的袋子，里面的元素 **唯一且不重复**。
- **添加**：`SADD key member`
- **判断**：`SISMEMBER key member` (检查成员是否存在)
- **取交集**：`SINTER k1 k2` (找共同好友)
- **场景**：去重、抽奖系统、共同关注。

---

## 08. 有序集合 Sorted Set

**通俗理解**：在 Set 的基础上，给每个成员关联一个 **Score（分数）**，Redis 会按分数自动排序。
- **添加**：`ZADD key score member`
- **查看**：`ZRANGE key 0 -1 [WITHSCORES]` (按分数从小到大排)
- **反向排序**：`ZREVRANGE` (从大到小)
- **场景**：游戏积分排行榜、热搜榜。

---

## 09. 哈希 Hash

**通俗理解**：像一个 Excel 表的一行，或者是一个对象（Object）。
- **设置**：`HSET user:1 name "Tom" age 20`
- **获取**：`HGET user:1 name`
- **全部获取**：`HGETALL user:1`
- **场景**：存储用户信息（比 String 更省内存，且支持部分更新）。

---

## 10. 发布订阅模式

**通俗理解**：像广播电台。一个人发，所有听众都能收到。
- **订阅者**：`SUBSCRIBE channel1`
- **发布者**：`PUBLISH channel1 "Hello Redis"`
- **注意**：消息是即时的，如果听众当时不在线，消息就丢了（这也是后来引入 Stream 的原因）。

---

## 11. 消息队列 Stream（完整实操记录）

### 11.1 生产消息 (XADD)
`XADD geekhour * course git` -> `*` 表示由 Redis 自动生成消息 ID（时间戳-序列号）。

### 11.2 查看消息 (XLEN / XRANGE)
`XRANGE geekhour - +` 查看队列中所有历史消息。

### 11.3 读取消息 (XREAD)
`XREAD COUNT 2 BLOCK 10000 STREAMS geekhour $` -> 阻塞 10 秒，只读新消息。

### 11.4 消费者组 (XGROUP)
`XGROUP CREATE geekhour group1 0` -> 创建名为 group1 的组，从头开始消费。

### 11.5 消费与确认 (XREADGROUP / XACK)

- **消费**：`XREADGROUP GROUP group1 consumer1 STREAMS geekhour >`
- **确认**：`XACK geekhour group1 1-0` (告知 Redis 该消息已处理，从待处理列表移除)。

---

## 12. 地理空间 Geospatial (GEO)

- **添加位置**：`GEOADD city 116.40 39.90 beijing`
- **计算距离**：`GEODIST city beijing shanghai KM`
- **范围搜索**：`GEOSEARCH city FROMMEMBER shanghai BYRADIUS 300 KM`

---

## 13. HyperLogLog (PF)

**特点**：极省内存的基数统计（去重计数），误差约 0.81%。
- **添加**：`PFADD uv user1 user2 user1`
- **统计**：`PFCOUNT uv` (结果为 2)
- **场景**：统计网站每日 UV（独立访客）。

---

## 14. 位图 Bitmap

**特点**：每个 bit 存 0/1。

- **设置**：`SETBIT sign:101 0 1` (第 0 天签到)
- **统计**：`BITCOUNT sign:101` (统计签到天数)

---

## 15. 位域 Bitfield

**特点**：在字符串中划分多个字段存数字。
- **示例**：`BITFIELD player:1 set u8 #0 1` (在第 0 个位置存一个 8 位无符号整数)。

---

## 16. 事务

**核心命令**：`MULTI` (开始) -> `入队` -> `EXEC` (执行)。
**重要结论**：
1. **不支持回滚**：如果事务中某条命令执行失败，其他命令会继续执行，不会撤回。
2. **原子性**：入队阶段如果命令语法错，整个事务才不执行。

---

## 17. 持久化

### 17.1 RDB (快照)
- **原理**：定时把内存数据“拍照”存到磁盘（dump.rdb）。
- **优点**：恢复快，适合备份。
- **缺点**：如果两次快照间宕机，会丢失数据。

### 17.2 AOF (日志)
- **原理**：把每条写命令都记录下来（appendonly.aof）。
- **优点**：数据安全性极高。
- **缺点**：文件大，恢复相对慢。

---

## 18. 主从复制

**原理**：一个 Master（主），多个 Slave（从）。
- **作用**：
    1. **读写分离**：主写从读，提升并发能力。
    2. **数据备份**：多个副本更安全。
- **配置**：在从库执行 `REPLICAOF master_ip port`。

---

## 19. 哨兵模式

**原理**：哨兵（Sentinel）是 Redis 的监控程序。
- **功能**：
    1. **监控**：检查主从库是否正常。
    2. **自动故障转移**：如果 Master 挂了，哨兵会自动选出一个 Slave 升级为新的 Master。
    3. **通知**：告知客户端新的 Master 地址。

---

## 补充知识

### 命令命名规则
| 缩写 | 全称 | 例子 |
| :--- | :--- | :--- |
| **S** | Set | `SADD` |
| **Z** | Sorted Set | `ZADD` |
| **H** | Hash | `HSET` |
| **X** | Stream | `XADD` |
| **L/R** | Left/Right | `LPUSH` |

### 常见报错处理
- `Connection refused`：Redis 服务没开。
- `ERR unknown command`：命令拼错（如 `STRAMS`）。
- `'cp' is not recognized`：Windows 下请用 `copy`。

### 需要记住的关键路径
- **安装目录**：`D:\code\redis\Redis\`
- **工作目录**：`CONFIG GET dir` 决定了持久化文件的存放位置。

### 实用命令速查
- `KEYS *`：查看所有键。
- `TYPE key`：查看键的类型。
- `TTL key`：查看过期剩余时间。
- `FLUSHALL`：清空所有数据库。
