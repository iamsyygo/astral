import 'package:flutter/material.dart';

class SheetView extends StatelessWidget {
  final List<Widget> children;
  final Color? background;
  final BorderRadiusGeometry borderRadius;
  final String? title;

  const SheetView(
      {super.key,
      required this.children,
      this.background = Colors.white,
      this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
      this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          if (title != null)
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: Text(title!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ),
          Container(
            decoration: BoxDecoration(
              color: background,
              borderRadius: borderRadius,
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class SheetViewItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;
  final Widget? leading;
  final Widget? trailing;
  final Color? iconColor;

  const SheetViewItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.showDivider = true,
      this.leading,
      this.trailing,
      this.iconColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          splashColor: Colors.transparent, // 去除点击水波纹
          minTileHeight: 50,
          leading: leading ?? Icon(icon, color: iconColor),
          title: Text(title, style: const TextStyle(fontSize: 16)),
          trailing: trailing ??
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFBBBBBB),
                size: 24,
              ),
          onTap: onTap,
        ),
        if (showDivider)
          const Divider(
              height: 0.4,
              thickness: 0.4,
              indent: 18,
              endIndent: 30,
              color: Color(0xffc5c5c6)),
      ],
    );
  }
}
