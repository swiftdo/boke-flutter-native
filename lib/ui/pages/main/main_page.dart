import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oldbirds/states/states.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/ui/ui.dart';
import '../home/home_page.dart';
import '../learn/learn_page.dart';
import '../mine/mine_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MainBottomBarState>(
      model: MainBottomBarState(),
      builder: (ctx, state, child) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: <Widget>[HomePage(), LearnPage(), MinePage()],
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context, state),
        );
      },
    );
  }

  Widget _navBarIcon(String image) {
    return SvgPicture.asset(
      image,
      width: 24,
      color: Colors.grey,
    );
  }

  Widget _navBarActiveIcon(String image) {
    return Container(
      padding: EdgeInsets.all(8),
      child: SvgPicture.asset(
        image,
        color: Color(0xffEF543C),
      ),
    );
  }

  Widget _navBarTitle(String title) {
    return Container(
      padding: EdgeInsets.only(top: 3),
      child: Text(
        title,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, MainBottomBarState state) {
    return FluidNavBar(
      icons: <Widget>[
        _navBarIcon("assets/images/tab_home.svg"),
        _navBarIcon("assets/images/tab_learn.svg"),
        _navBarIcon("assets/images/tab_mine.svg"),
      ],
      activeIcons: <Widget>[
        _navBarActiveIcon("assets/images/tab_home.svg"),
        _navBarActiveIcon("assets/images/tab_learn.svg"),
        _navBarActiveIcon("assets/images/tab_mine.svg"),
      ],
      titles: <Widget>[
        _navBarTitle('首页'),
        _navBarTitle('学习'),
        _navBarTitle('我的')
      ],
      onChange: (index) {
        state.setCurrentIndex(index);
      },
    );
  }
}
