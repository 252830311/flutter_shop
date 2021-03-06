import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/member_page.dart';
import 'package:flutter_shop/widget/appbar_gradient.dart';

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  String _currentTitle = '首页';

  final List<BottomNavigationBarItem> _bottomItems = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.book), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  final List<Widget> tabPages = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    // 放在第一个页面初始化。设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按 iPhone6 的尺寸设计的 (iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        appBar: gradientAppBar(),
        body: IndexedStack(
          //IndexedStack防止底部tabs重新加载
          children: tabPages,
          index: _currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: _bottomItems,
          onTap: (index) {
            // print('点击了 index $index');
            setState(() {
              _currentIndex = index;

              String textTitle = _bottomItems[index].title.toString();
              int first = textTitle.indexOf('\"');
              int second = textTitle.lastIndexOf('\"');
              _currentTitle = textTitle.substring(first + 1, second);
            });
          },
        ));
  }

  /// 渐变色AppBar
  Widget gradientAppBar() {
    return GradientAppBar(
      gradientStart: Color(0xFF49A2FC),
      gradientEnd: Theme.of(context).primaryColor,
      //  gradientStart: Color(0xFF49A2FC), //手Q渐变色
      //  gradientEnd: Color(0xFF2171F5),
      title: Text(_currentTitle),
      centerTitle: true,
    );
  }
}
