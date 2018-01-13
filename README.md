# SERIS
## 中文版见下方
A Distributed Programmable Scale-Free Network Framework

## A Problem
As the traditional central-based systems like cloud computing, social network grows, we are tolarating too much of uncontrollable supervisors and monitors. Our voices, photos, credit cards are all under their control, our articles can be easily blocked, our security is based on their honest. But how can we do if they are not honest? The answer is none but keep silent.

Rather than to tolarate their dishonest, fool, evil, why shouldn't we give it a change, build a network without supervisor, make our network more clean.

Seris is a network framework built for this purpose. It is an extendible scale-free network without special nodes, moreover, programmable. So all nodes are born equal.

## Why seris
### Safe
Seris is a real scale-free network, all nodes are equal with each other. So there is no special node in seris. Follow the direction, program built on seris can have no supervisor or monitor.
### Extendible
A node can join to any network, so does a network. several network can merge into one network. In other word, any device can connect to any device. The network can be extend to the whole internet of things.
### Robust
So long as the network is big enough, any node has several connections with the network. Any unavailable node will not affect the connectivity of the whole network. The network is always connectable.
### Flexible
Seris is programmable in several languages. This gives seris an unlimited ability.
### Efficient
As you connect to seris, program it, a whole network work for you.
### Economical
As said before, you use the compute ability of whole internet as a reward of sharing your compute ability with the network.
### Convinient
We support all unix-based system, as well as android, mac, ..., and virtual os.
### Easy
As long as you follow some very simple rules, program on seris is as easy as program locally. Besides, seris also provide some inner functions to help programming. 
### Light
Seris is a light weight framework. Less than 30 KB source so far. This makes seris deployable on any device including embedded devices like phone, chips, etc.
### Cool
Finally, it's cool.

## How It Works
For shell version, each node use nc(netcat) to open a port for tcp listening.
There are 5 different message types: ODR(order), CNC(cancel), HBT(heart beat), RST(result), GTT(got it). Each of them has a different usage and message body.

## Message Format
### Message Information
|Msg Type|Meaning|Need Response|Resend Condition|
|:-:|:-:|:-:|:-|
|ODR|Order|Y|No GTT Received|
|CNC|Cancel||RST/HBT Received|
|HBT|Heart Beat||As Long As Alive|
|RST|Result|Y|No GTT Received|
|GTT|Got It||Never|

### Message Content
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
#### Run Test Code
    cd seris/test/local
    ./mkenv.sh

# SERIS 
可分布式编程的无尺度网络架构
