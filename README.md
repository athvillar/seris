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
可编程的分布式无尺度网络框架

未完待续
