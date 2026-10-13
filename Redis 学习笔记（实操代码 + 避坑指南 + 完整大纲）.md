【【软件架构师】一小时掌握Redis(锁，消息队列，Lua，哨兵集群)】https://www.bilibili.com/video/BV1o4p568Etd?vd_source=3424baa0ba17a6687e097f58c68731c5









```redis
# ====== 字符串 String ======
SET name geekhour
GET name
Set Name Geekhour
get Name
Exists name
EXISTS names
GET names
KEYS *
KEYS *me

# ====== 清库 ======
FLUSHDB
FLUSHALL
KEYS *

# ====== 切换库（含拼写错误演示） ======
SELECT 0
SECELT 1          # 故意写错，演示 ERR unknown command
SELECT 1
KEY *             # 故意写错，演示 ERR unknown command
KEYS *
SELECT 0

# ====== 中文存储 + TTL ======
SET name 血狼破军
get name
quit
redis-cli --raw
get name
TTL name
EXPIRE name 10
TTL name
GET name
KEYS name
SETEX name 10 血狼破军
TTL name
SETNX name 勤劳勇敢
GET name
KEYS *
FLUSHDB

# ====== 列表 List ======
LPUSH letter a
LRANGE letter 0 -1
LPUSH letter b
LRANGE letter 0 -1
LPUSH letter c d e
RPUSH letter f
LRANGE letter 0 -1
LPUSH letter c
LRANGE letter 0 -1
RRANGE letter 0 -1       # 故意写错
RRANGE letter -1 0       # 故意写错
LPOP
LPOP letter
LPOP letter 2
LLEN letter
FLUSHALL
LPUSH letter a b c d ee
KEYS letter
LRANGE letter 0 -1
LTRIM letter 1 3
LRANGE letter 0 -1
FLUSHDB
KEYS *

# ====== 集合 Set ======
SADD course Redis
SMEMBERS course
SADD course Redis
SMEMBERS course
SADD course REdis
SMEMBERS course
SISMEMBER course Redis
SISMEMBER course Python
SREMOVE course Redis     # 故意写错
SREM course REdis
SMEMBERS course
SREM course Redis
SMEMBERS course
KEYS *
FLUSHDB

# ====== 有序集合 Sorted Set ======
ZADD result 680 清华 660 北大 650 复旦 640 浙大
ZRANGE result 0 -1
ZREVERSE result 0 -1     # 故意写错
ZREVERST result          # 故意写错
ZRANGE result 0 -1 WITHSCORES
ZSCORE result 清华
ZRANK result 清华
ZREVRANK result          # 故意少参数
ZREVRANK result 清华 WITHSCORE
KEYS *
FLUSHDB

# ====== 哈希 Hash ======
HSET person name laoyang
HSET person age 100
KEYS *
HGET person name
HGET person age
HGETALL person
HEGT person            # 故意写错
HDEL person age
HGETALL person
HEXISTS person name
HEXISTS person age
HKEYS person
KEYS person
KEYS *
HLENS person           # 故意写错
HLEN person
FLUSHDB

# ====== 发布订阅 ======
PUBLISH geekhour redis
publish geekhour redis
publish geekhour redis
PUBLISH geekhour git
PUBLISH geekhour docker
KEYS *
FLUSHDB                # 最后你自己清了库

# ====== Stream 消息队列 ======
XADD geekhour * course git
XADD geekhour * couser docker
XADD geekhour * course redis
XLEN geekhour
XRANGE geekhour - +
XDEL geekhour 1786002204048-0
XRANGE geekhour - +
XTRIM geekhour MAXLEN 0
XRANGE geekhour - +
XADD geekhour 1-0 course git       # 演示 ID 冲突报错
FLUSHALL
XADD geekhour 1-0 course git
XADD geekhour 2-0 course docker
XADD geekhour 3-0 course redis
XRANGE COUNT 2 BLOCK 1000 STREAMS geekhour 0   # 在 Workbench 不支持
FLUSHALL

# ====== 消费者组 ======
XGROUP CREATE geekhour group1 0
XINFO GROUPS geekhour
XGROUP CREATECONSUMER geekhour group1 consumer1
XINFO GROUPS geekhour
XINFO CONSUMERS geekhour group1
XREADGROUP GROUP group1 consumer1 COUNT 2 BLOCK 3000 STREAMS geekhour >
XACK geekhour group1 1-0

# ====== 位图 Bitmap ======
SET dianzhan "\xF0"
BITPOS dianzhan 0
BITPOS dianzhan 0 0 3
BITPOS dianzhan 0 4 7
BITPOS dianzhan 1 4 7
```







| 对比           | Set（集合）    | Zset（有序集合）       |
| :------------- | :------------- | :--------------------- |
| 元素是否唯一   | ✅ 唯一         | ✅ 唯一                 |
| 是否有序       | ❌ 无序         | ✅ **按分数排序**       |
| 每个元素带什么 | 只有值         | **值 + 分数（score）** |
| 适用场景       | 共同好友、标签 | 排行榜、带权重的队列   |

```redis
# 添加（元素 = 清华，分数 = 680）
ZADD result 680 清华  //ZADD result 680 清华 660 北大 650 复旦 640 浙大    参考上面

# 查看（升序，分数低的在前）
ZRANGE result 0 -1
# → 浙大 复旦 北大 清华

# 查看（降序，分数高的在前）
ZREVRANGE result 0 -1
# → 清华 北大 复旦 浙大

# 查看分数
ZSCORE result 清华      # 680

# 查看排名（升序，0 是分数最低的）
ZRANK result 清华       # 3

# 查看排名（降序，0 是分数最高的）
ZREVRANK result 清华    # 0

# 给某个元素加/减分
ZINCRBY result 50 清华  # 清华 +50 分，变成 730

# 删除
ZREM result 清华
```









# Redis 学习笔记（实操代码 + 避坑指南 + 完整大纲）

> **说明**：本笔记不仅包含 Redis 的核心知识点，还深度整合了你在 Windows 环境下的所有真实交互日志。保留了所有成功的操作、典型的报错以及工具限制的提示，是一份真正的“实操手册”。

---

## 01. 课程简介

Redis 是目前全球最快、最流行的键值对存储数据库。本笔记旨在记录从零开始的实操过程，涵盖所有踩过的坑与解决方案。

---

## 02. Redis 简介

- **定义**：Remote Dictionary Server，内存级 KV 数据库。
- **核心优势**：极速（内存操作）、简单（单线程模型）、强大（支持多种数据结构）。
- **应用场景**：缓存、排行榜、计数器、分布式锁、消息队列等。

---

## 03. 安装配置（实操完整记录）

### 3.1 关键路径与文件
你的安装目录：`D:\code\redis\Redis\`
- `redis-server.exe`：服务端
- `redis-cli.exe`：命令行客户端
- `redis.conf`：核心配置文件

### 3.2 启动与连接
```cmd
# 切换目录并启动
cd /d D:\code\redis\Redis
redis-server.exe

# 另开窗口连接
redis-cli
127.0.0.1:6379> PING
PONG
```

### 3.3 避坑贴士：Windows 路径与命令
| 报错信息 | 原因分析 | 解决方案 |
| :--- | :--- | :--- |
| `'cp' is not recognized` | 在 CMD 中误用了 Linux 命令 | 使用 `copy redis.conf %USERPROFILE%` |
| `'ls' is not recognized` | 在 CMD 中误用了 Linux 命令 | 使用 `dir` 或 `dir /O:D` (按时间排序) |
| `cd ~` 报错 | CMD 不支持 `~` 代表家目录 | 使用 `cd /d %USERPROFILE%` |
| `Cannot find dump.rdb` | Redis 工作目录默认在 System32 | `CONFIG SET dir "D:/code/redis/Redis"` |

---

## 04. GUI 工具 RedisInsight

**实操记录：Workbench 的局限性**
在使用 RedisInsight 的 Workbench 执行命令时，你可能会遇到以下提示：
> `"XREAD is not supported by the Workbench. Unsupported commands: blpop, xread, xreadgroup, monitor, subscribe..."`

**结论**：对于涉及 **阻塞 (Blocking)** 或 **订阅 (Subscribe)** 的长连接命令，必须使用原生 `redis-cli` 终端执行。

---

## 05. 字符串 String

- **基础**：`SET k1 v1` / `GET k1`
- **计数**：`INCR k3`
- **清理**：`FLUSHALL` (清空所有数据库)

---

## 06. 列表 List

- **操作**：`LPUSH` / `RPUSH` (左右插入)，`LPOP` / `RPOP` (左右弹出)。
- **查看**：`LRANGE key 0 -1`。

---

## 07. 集合 Set

- **唯一性**：自动去重，适合存好友列表、抽奖名单。
- **命令**：`SADD` / `SISMEMBER` / `SINTER` (交集)。

---

## 08. 有序集合 Sorted Set

- **排序**：`ZADD score member`。
- **场景**：游戏排行榜。

---

## 09. 哈希 Hash

- **对象存储**：`HSET user:1 name "Tom"`。
- **优势**：比 String 更节省空间，支持修改单个字段。

---

## 10. 发布订阅模式

- **即时通信**：`SUBSCRIBE` / `PUBLISH`。
- **局限**：消息不持久化，错过即丢失。

---

## 11. 消息队列 Stream（深度实操记录）

### 11.1 生产消息 (XADD)
```redis
# 自动生成 ID
XADD geekhour * course git      # 返回 "1786002140653-0"
XADD geekhour * course redis    # 返回 "1786002204048-0"

# 手动指定 ID（必须递增）
XADD geekhour 1-0 course git
XADD geekhour 2-0 course docker
```
**避坑**：如果 ID 小于等于当前最大 ID，会报错：
> `(error) ERR The ID specified in XADD is equal or smaller than the target stream top item`

### 11.2 查看与管理
```redis
XLEN geekhour                  # 查看长度
XRANGE geekhour - +            # 查看所有消息
XDEL geekhour 1786...-0        # 删除特定消息
XTRIM geekhour MAXLEN 0        # 清空 Stream
```

### 11.3 读取消息 (XREAD)
```redis
# 从头开始读 2 条
XREAD COUNT 2 STREAMS geekhour 0

# 阻塞读取新消息 (原生 cli 支持，Workbench 不支持)
XREAD COUNT 2 BLOCK 10000 STREAMS geekhour $
```

### 11.4 消费者组 (XGROUP)
```redis
# 创建组
XGROUP CREATE geekhour group1 0

# 查看组信息 (lag 表示积压的消息数)
XINFO GROUPS geekhour
# 返回包含 "name": "group1", "lag": 7 等信息

# 创建消费者
XGROUP CREATECONSUMER geekhour group1 consumer1

# 消费并确认
XREADGROUP GROUP group1 consumer1 COUNT 2 STREAMS geekhour >
XACK geekhour group1 1-0
```

---

## 12. 地理空间 GEO（实操记录）

```redis
# 添加北京经纬度
GEOADD city 116.405285 39.904989 beijing

# 批量添加
GEOADD city 121 31 shanghai 114 22 shenzhen 37 23 guangzhou 120 30 hangzhou

# 计算距离 (默认米，可指定 KM)
GEODIST city beijing shanghai KM   # "1073.9758"

# 范围搜索
GEOSEARCH city FROMMEMBER shanghai BYRADIUS 300 KM
```

---

## 13. HyperLogLog (PF)

```redis
PFADD course git docker redis
PFCOUNT course                 # 返回 3
PFMERGE course2 course course2 # 合并多个统计结果
```

---

## 14. 位图 Bitmap

```redis
SETBIT dianzhan 0 1
GETBIT dianzhan 0              # 返回 1
BITCOUNT dianzhan              # 统计 1 的个数
```

---

## 15. 位域 Bitfield

```redis
# 在第 0 个位置存一个 8 位无符号整数
BITFIELD player:1 set u8 #0 1
# 增加数值
BITFIELD player:1 incrby u32 #1 100
```

---

## 16. 事务（实操记录）

```redis
MULTI
SET k1 v1
SET k1 v2
EXEC                           # 返回 OK, OK
```
**执行报错示例**：
```redis
MULTI
INCR k3                        # 成功
INCR k4                        # 报错 (k4 是字符串)
INCR k5                        # 成功
EXEC
```
**结论**：Redis 事务不保证原子回滚，失败的命令不影响其他命令。

---

## 17. 持久化

- **RDB (快照)**：`SAVE` (同步) / `BGSAVE` (异步)。
- **AOF (日志)**：记录每条指令，安全性更高。

---

## 18. 主从复制

- **配置**：`REPLICAOF master_ip port`。
- **作用**：读写分离，负载均衡。

---

## 19. 哨兵模式

- **作用**：自动监控 Master，挂掉后自动选举新 Master。

---

## 20. 实用命令速查（基于你的 KEYS）

| 命令 | 示例 | 说明 |
| :--- | :--- | :--- |
| `KEYS *` | 查看当前库所有 Key | `1) "course" 2) "city" 3) "k3" ...` |
| `TYPE key` | `TYPE geekhour` | 查看数据类型 (stream/string/zset 等) |
| `SAVE` | `save` | 强制将内存数据存入磁盘 |
| `EXIT` | `exit` | 退出 redis-cli |
| `redis-cli` | `redis-cli` | **避坑**：在 cli 内部输入 `redis-cli` 会报 `unknown command` |
