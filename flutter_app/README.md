# flutter_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
Android平台解决方案
第一步：修改 AndroidManifest.xml

首先，你需要在 Android 项目的 AndroidManifest.xml 文件中设置 networkSecurityConfig 属性，以允许应用处理非安全的网络请求。

1、打开 android/app/src/main/AndroidManifest.xml 文件。

2、在 <application> 标签中添加 android:networkSecurityConfig 属性，指向你的网络安全配置文件。

<application
    ...
    android:networkSecurityConfig="@xml/network_security_config">
</application>
第二步：创建network_security_config.xml

1、在 android/app/src/main/res/xml 目录下（如果目录不存在，则需要创建它）创建一个名为 network_security_config.xml 的文件。

2、在该文件中添加以下内容，以允许应用处理明文流量（HTTP请求）：

<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true">
        <trust-anchors>
            <certificates src="system" />
            <certificates src="user" />
        </trust-anchors>
    </base-config>
</network-security-config>
这个配置告诉 Android 系统，你的应用将允许非加密的网络流量（即 HTTP 请求）。
webview_flutter插件显示网页的时候在iOS无法显示
解决办法：在info.list添加：

 <dict>
   <key>io.flutter.embedded_views_preview</key>
    <true/>
  </dict>
如果需要访问 HTTP 网页，还需要添加以下。


    <key>NSAppTransportSecurity</key>
    <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    </dict>