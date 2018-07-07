### 实现效果展示

1. 未启动模拟器   ![](https://ws4.sinaimg.cn/large/006tKfTcgy1ft1pvtridbj302s036wed.jpg) 

2. 启动模拟器后，点击刷新   ![](https://ws1.sinaimg.cn/large/006tKfTcgy1ft1py3xhpfj302s033wed.jpg)

3. 选中对应app的cell，跳转至沙盒文件夹   ![沙盒文件夹](https://ws1.sinaimg.cn/large/006tKfTcgy1frbv2pxllgj305k035wf0.jpg)

   ​    
### 沙盒目录简介

1. Documents 目录：您应该将所有的应用程序数据文件写入到这个目录下。这个目录用于存储用户数据。该路径可通过配置实现iTunes共享文件。可被iTunes备份。 

2. Library 目录：这个目录下有两个子目录： 

   Preferences 目录：包含应用程序的偏好设置文件。您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好. 

   Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。  可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份。 

3. tmp 目录：这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息。该路径下的文件不会被iTunes备份。 

在app运行中我们经常使用NSHomeDirectory()来查看沙盒目录，但该方式有以下缺点：

1. 每次需要查看时需要重新运行项目
2. 当控制台日志较多时，查看起来不是那么方便



### 大体流程

1. 搭建软件界面

   1. 使用NSStatusBar的statusItemWithLength:方法，这个方法会创建好一个NSStatusItem，并且将它自动的添加到状态栏中
   2. 使用NSPopover创建气泡视图(类似iPad开发中的UIPopoverPresentationController)，我们的交互控件都添加至NSPopover的控制器中
   3. NSPopover中由NSOutlineView、刷新按钮与关闭按钮组成
   4. 删除window，设置NSApplication的delegate
2. 将标准输出流重定向至一临时的文本文件(可以使用C语言的freopen函数，也可以使用Unix的dup2函数，这里使用的是echo命令)
3. xcrun simctl list --json 获取模拟器列表并格式化为json文件，在工程配置中关闭沙盒机制(如不关闭，无权限访问沙盒以外目录或文件)
4. 筛选state字段为Booted的模拟器，使用xcrun simctl listapps udid获取模拟器所安装的app列表
5. 监听点击事件，使用open命令打开相应的沙盒目录


### Mac OS 开发初探

文件结构大致与iOS App一样，NSWindow  ≈ UIWindow，NSViewController ≈ UIViewController，NSOutlineView ≈ UITableView

事件监听：

```objc
[NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDown 
                                           handler:^(NSEvent * _Nonnull event) {
                                           }];
```

注意点：

- 从工程配置去除Main.SB之后，系统不会创建NSAppDelegate并设置为App的代理，而是需手动设置App代理
- xcrun simctl listapps udid 命令只能查询启动的模拟器设备，因此执行该命令需保证模拟器的开启
- Mac App也有沙盒的概念，但是我们需要访问沙盒以外的目录，因此需关闭沙盒机制，保证有权限访问其他目录



### 工具推荐

模拟器沙盒目录访问工具：simpholders

真机沙盒目录访问工具：iExplorer



### 参考与拓展

Mac OS X开发：https://www.jianshu.com/u/a1aee6e433fb

dup2 + NSPipe重定向：http://lizaochengwen.iteye.com/blog/1476080
