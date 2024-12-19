import 'dart:async';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  /// 轮播图中展示的内容列表
  final List<Widget> items;

  /// 自动播放间隔时间
  final Duration autoPlayInterval;

  /// 是否自动播放
  final bool autoPlay;

  /// 轮播图的高度
  final double height;

  const BannerWidget({
    super.key,
    required this.items,
    this.autoPlay = true,

    /// Duration 是一个时间段，单位是毫秒
    this.autoPlayInterval = const Duration(seconds: 3),
    this.height = 200.0,
  });

  @override

  /// ignore: library_private_types_in_public_api
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  /// PageView 控制器
  late PageController _pageController;
  int _currentPage = 0;

  /// 当前显示的页面索引
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    if (widget.autoPlay) {
      /// 启动自动播放
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    /// 页面销毁时取消计时器
    _autoPlayTimer?.cancel();

    /// 销毁 PageController
    _pageController.dispose();

    super.dispose();
  }

  /// 开始自动播放
  void _startAutoPlay() {
    /// Timer.periodic 是一个周期性的计时器，每隔一段时间执行一次回调函数
    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (timer) {
      /// TODO Banner 轮播图算法推荐
      /// 算法为：将当前页面索引加 1，如果超出了页面总数，则回到第一页
      _currentPage = (_currentPage + 1) % widget.items.length;
      _pageController.animateToPage(
        _currentPage,

        /// 动画持续时间 300 毫秒
        duration: const Duration(milliseconds: 300),

        curve: Curves.easeInOut,
      );
    });
  }

  /// 手动切换页面时重置自动播放计时器
  void _resetAutoPlay() {
    if (_autoPlayTimer != null) {
      _autoPlayTimer!.cancel();
      _startAutoPlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          /// 轮播图容器的高度
          height: widget.height - 10.0,

          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              // 阻止通知冒泡到父组件
              return true;
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.items.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
                _resetAutoPlay();
              },
              itemBuilder: (context, index) {
                return widget.items[index];

                /// 显示每个轮播图的内容
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          /// 小圆点指示器的布局
          children: List.generate(widget.items.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              width: _currentPage == index ? 5.0 : 3.0,
              height: _currentPage == index ? 5.0 : 3.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? const Color(0xff80d348)
                    : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
