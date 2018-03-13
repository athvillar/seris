# SERIS
A Distributed Programmable Scale-Free Network Framework
##### 中文版见下方

## A Problem
As the traditional central-based systems like cloud computing, social network grows, we are tolarating too much of uncontrollable supervisors and monitors. Our voices, photos, credit cards are all under their control, our articles can be easily blocked, our security is based on their honest. But how can we do if they are not honest? The answer is none but keep silent.

Rather than to tolarate their dishonest, fool, evil, why shouldn't we give it a change, build a network without supervisor, make our network more clean.

Seris is a network framework built for this purpose. It is an extendible scale-free network without special nodes, moreover, programmable. So all nodes are born equal.

## Why Seris
### Safe
Seris is a real scale-free network, all nodes are equal with each other. So there is no special node in seris. Follow the direction, programs built on seris can have no supervisor or monitor.
### Extendible
A node can join to any network, so does a network. several networks can merge into one network. In another word, any device can connect to any device. The network can be extended to the whole internet of things.
### Robust
So long as the network is big enough, every node has several connections with the network. Any unavailable node will not affect the connectivity of the whole network. The network is always connectable.
### Flexible
Seris is programmable in several languages. This gives seris an unlimited ability.
### Efficient
As you connect to seris, program on it, a whole network work for you.
### Economical
As said before, you use the compute ability of whole internet as a reward of sharing your compute ability with the network.
### Convinient
Seris support all unix-based system, as well as android, mac, ..., and virtual OS.
### Easy
As long as you follow some very simple rules, programming on seris is as easy as programming locally. Besides, seris also provide some inner functions to help programming. 
### Light
Seris is a light weight framework. Less than 30 KB source so far. This makes seris deployable on any device including embedded devices like phone, chips, etc.
### Cool
Finally, it's cool.

## How It Works
For shell version, each node uses nc(netcat) to open a port for tcp listening. Once a message is received, listener informs a controller to process with it. Depend on the message contents, controller distributs the order to other nodes or processes itself. Thus an order begins flowing all over the internet.

## Message Format
There are 5 different message types: ODR(order), CNC(cancel), HBT(heart beat), RST(result), GTT(got it). Each of them has a different usage and message body.
### Message Types
|Msg Type|Meaning|Need Response|Resend Condition|
|:-:|:-:|:-:|:-|
|ODR|Order|Y|No GTT Received|
|CNC|Cancel||RST/HBT Received|
|HBT|Heart Beat||As Long As Alive|
|RST|Result|Y|No GTT Received|
|GTT|Got It||Never|

### Message Contents
|Msg Type|Msg ID|NodeID|Node Host|Node Port|Task ID|TTK|Max Time|Time Out|Dispatch Condition|Registry|Param|Dispatched Nodes|Elapsed Time|Estimated Time|Total Index|Index|Result|Corresponding Msg ID|EOF|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|ODR|Y|Y|Y|Y|Y|Y|Y|Y|Y|Y|Y||||||||Y|
|CNC|Y|Y|||Y||||||||||||||Y|
|HBT|Y|Y|||Y|||||||Y|Y|Y|||||Y|
|RST|Y|Y|||Y||||||||||Y|Y|Y||Y|
|GTT|Y|Y|||Y|||||||||||||Y|Y|

## Run Seris
### Docker Version
Not finished yet.
### By Source
#### Download Seris
    git clone https://github.com/athvillar/seris.git
#### Build Local Test Env
    cd seris/
    test/local/mkenv.sh
#### Run a Test Program
    test/runtest.sh ping

## How to Program on Seris
The seris/registry folder is for user's program. The program can be registered as a username/programname format program.

To be continued...

# SERIS
一个可编程的无尺度网络架构

## 一个问题
传统的中心化的网络结构，例如云计算、社交网络，有一个共同的问题－－即总有一个管理者，或者说监视者。我们说的话、发的照片、信用卡信息都在他们的掌握中，我们发表的文章可能被随时删帖，我们的安全建立在他们的诚实基础上。如果他们不诚实，我们似乎也没什么办法。

与其忍受他们的欺骗、愚蠢和邪恶，我们为什么不试着建立一个没有监督者的网络，让我们的网络更纯净。

Seris就是为了这个目的而建立的。她是一个可无限扩展的无尺度网络，没有中心节点，而且是可编程的。在Seris上我们真正可以说：人生而平等。

## 为什么使用Seris
### 安全
Seris是一个真正的无尺度网络，所有的节点都与其他节点有同样的地位。所以在Seris中没有特殊的节点。按照特定的规则编程，在Seris上编写的应用是没有监视者的。
### 可扩展
一个节点可以加入任何网络，一个网络也可以和任何网络连接。多个网络可以融合为一个大网络，任何设备都可以连接到任何设备上。Seris网络可以扩展到整个物联网。
### 健壮
只要网络足够大，每个节点都有多个路径连接到网络上。任何一个节点失效，都不会影响整个网络的连通性。网络总是可用的。
### 弹性
Seris可以用多种语言进行编程，这使得Seris可以跨平台。
### 高效
Seris可以使整个网络为你工作。
### 经济
Seris使网络计算资源共享。
### 便利
Seris目前支持所有Unix系统，包括android, mac, ..., 和虚拟机。
### 简单
编写Seris程序像编写本地程序一样简单。除此之外，Seris还提供一些辅助函数帮助编程。
### 轻量
Seris是一个轻量级框架。到目前为止代码不超过30KB。这使得Seris可以很容易地部署到嵌入式设备上。
### 酷
当然，Seris很酷。

## 如何工作
对于shell版本，每个节点使用nc（netcat）打开一个端口监听某个tcp请求。当收到请求，控制器将请求发给其他节点或者自己处理。这样一个请求就在互联网上传播开。

## 报文格式
有五种报文：ODR（命令），CNC（取消），HBT（心跳），RST（结果），GTT（收到）。每种报文都有不同的用途和报文体。
### 报文类型
|报文类型|意义|需要回复|重发条件|
|:-:|:-:|:-:|:-|
|ODR|命令|是|没有收到GTT|
|CNC|取消||收到RST/HBT|
|HBT|心跳||任务过程中持续|
|RST|结果|是|没有收到GTT|
|GTT|收到||永不|

### 报文内容
|报文类型|报文ID|节点ID|节点地址|节点端口|任务ID|生存期(TTL)|最大时间|超时时间|分发条件|注册程序|参数|分发节点|所用时间|估计时间|总索引|索引|结果|关联报文ID|结束符(EOF)|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|ODR|Y|Y|Y|Y|Y|Y|Y|Y|Y|Y|Y||||||||Y|
|CNC|Y|Y|||Y||||||||||||||Y|
|HBT|Y|Y|||Y|||||||Y|Y|Y|||||Y|
|RST|Y|Y|||Y||||||||||Y|Y|Y||Y|
|GTT|Y|Y|||Y|||||||||||||Y|Y|

## 运行Seris
### Docker版
未完成
### 从代码运行
#### 下载Seris
    git clone https://github.com/athvillar/seris.git
#### 创建本地测试环境
    cd seris/
    test/local/mkenv.sh
#### 执行测试程序
    test/runtest.sh ping

## 如何在Seris上编程
seris/registry目录是放置用户程序的目录，程序可以被注册为username/programname格式。

未完待续
