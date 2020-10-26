import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';

import 'package:oldbirds/ui/ui.dart';

import '../home/home_page.dart';
import '../learn/learn_page.dart';
import '../mine/mine_page.dart';
import 'main_viewmodel.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MainViewModel>(
      model: MainViewModel(),
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

  Widget _buildBottomNavigationBar(BuildContext context, MainViewModel state) {
    return FluidNavBar(
      icons: [
        FluidNavBarIcon(
          iconPath: "assets/images/tab_home.svg",
        ),
        FluidNavBarIcon(
          iconPath: "assets/images/tab_learn.svg",
        ),
        FluidNavBarIcon(
          iconPath: "assets/images/tab_mine.svg",
        ),
      ],
      style: FluidNavBarStyle(
        barBackgroundColor: Theme.of(context).primaryColor,
        iconSelectedForegroundColor: Colors.white,
        iconUnselectedForegroundColor: Theme.of(context).backgroundColor,
      ),
      onChange: (index) {
        state.setCurrentIndex(index);
      },
    );
  }
}
