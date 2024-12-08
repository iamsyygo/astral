# astral

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## AOT 与 JIT

AOT(Ahead Of Time)编译是在程序运行前将代码编译成机器码，JIT(Just In Time)编译是在程序运行时将代码编译成机器码。

Flutter 在开发阶段使用 JIT 编译，可以实现热重载(Hot Reload)功能，提高开发效率。在发布阶段使用 AOT 编译，提高运行性能。

## 声明式 UI

声明式 UI 是 Flutter 的核心特性之一，它描述 UI 应该是什么样子，而不是如何去构建它。

**优点**

- 更适合做多设备适配
- UI 布局和控制逻辑通过 reactive 方式实现数据绑定
- 更好实现 UI 的局部刷新机制，只更新需要刷新的部分

**与命令式 UI 的区别**

命令式 UI 需要手动操作 UI 元素，而声明式 UI 只需要描述想要的 UI 状态，框架会自动处理 UI 更新。

## Widget

A widget is an immutable object that represents a part of the user interface in Flutter. A widget has a type， which is a class that extends the [Widget] class.

翻译：Widget 是一个**不可变的**对象，表示 Flutter 用户界面中的一部分。Widget 有一个类型，它是一个扩展了 [Widget] 类的类。

以 Vue 开发举例，Widget 就像 Vue 中的组件(Component)。就像 Vue 组件可以包含模板、样式和逻辑，Flutter 中的 Widget 也可以包含 UI 结构、样式和行为。Vue 组件可以嵌套组合形成复杂的界面，Flutter 的 Widget 也是通过组合形成完整的应用界面。

Widget 的特点:

- 不可变性
- 组合性
- 层次结构
- 短暂性(每次重建都会创建新的 Widget 树)

## StatelessWidget 与 StatefulWidget

Flutter 中的 Widget 是不可变的，这意味着一旦创建就不能修改。但实际应用中，UI 往往需要根据用户交互或数据变化而更新。Flutter 通过 StatelessWidget 和 StatefulWidget 两种 Widget 来解决这个问题。

**StatelessWidget**

StatelessWidget 是无状态的 Widget，它不会随时间变化。适用于那些仅依赖于构造函数参数且不需要维护内部状态的 UI 组件，比如:

- 图标
- 文本
- 按钮样式
- 布局容器

**StatefulWidget**

StatefulWidget 是有状态的 Widget，**可以在 Widget 生命周期内动态改变。**当你需要根据用户交互或数据变化更新 UI 时，就需要使用 StatefulWidget。常见场景包括:

- 表单输入
- 动画
- 计数器
- 购物车

StatefulWidget 通过创建一个独立的 State 对象来管理状态。当状态发生变化时，调用 setState() 方法触发 Widget 重建，从而更新 UI。

## State

State 是 Flutter 中用于管理 Widget 状态的对象。State 通常与 StatefulWidget 一起使用，StatefulWidget 是 Flutter 中可变的 Widget。

State 对象的主要职责包括:

- 存储 Widget 需要的数据
- 响应用户交互和系统事件
- 通过 setState() 触发 Widget 重建
- 管理 Widget 的生命周期

State 的生命周期:

0. createState(): 创建 State 对象，当 StatefulWidget 被调用时会执行
1. initState(): State 对象被创建时调用，用于初始化状态。需要调用 super 重写父类方法
2. didChangeDependencies(): 依赖发生变化时调用
3. build(): 构建 Widget 树，返回需要渲染的 Widget
4. Reassemble(): 在开发阶段使用，用于调试。每次热重载时调用
5. didUpdateWidget(): Widget 配置发生变化时调用
6. deactivate(): State 对象被移除时调用
7. dispose(): State 对象被销毁时调用

使用 State 的最佳实践:

- 将状态封装在 State 类中
- 通过 setState() 更新状态
- 在 dispose() 中清理资源
- 避免在 build() 中执行耗时操作

需要注意:

- 不要直接修改 State 对象的属性，而是通过 setState() 更新状态
- 避免在 State 中直接访问外部变量，而是通过构造函数参数传递
- 在 dispose() 中取消监听和订阅，避免内存泄漏
- 即使调用 setState 修改的数据新旧值相同，也会触发重建

## 混合开发

Flutter 可以与原生应用混合开发，比如在 iOS 中使用 Swift 或 Objective-C，在 Android 中使用 Java 或 Kotlin。然后使用 Flutter 的 Platform Channel 与原生应用通信。

### 管理方式

**统一管理：**将 Flutter 工程作为主工程，原生应用作为子工程。由 Flutter 进行统一管理。

**三端分离管理：**将 Flutter 工程作为原生工程的子模块，维持原有的原生管理方式。

## Native 通信

Flutter 通过 Platform Channel 与原生应用通信。

Platform Channel 有三种类型:

- BasicMessageChannel: 用于传递 String 和 ByteData 类型数据
- MethodChannel: 用于传递方法调用
- EventChannel: 用于数据流(EventStream)传递

## 代码风格

1、可变数据放在 State 中，不可变数据放在 Widget 中。

```dart
class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  /// 一般不会把太多逻辑放在构造函数中，而是放在 State 中
  /// 因为 Widget 更多描述的是不可变的数据结构
  /// Widget 主要用于描述 UI 的结构和配置
  /// 构造函数参数通常是 final 的

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  /// 一般把逻辑放在 State 中
  /// 对于不需要给外部使用的数据，可以使用 _ 前缀来标识是私有数据


  static const _channel = const MethodChannel('test_channel');

  @override
  Widget build(BuildContext context) {
    return const Text('Hello, World!');
  }
}
```
