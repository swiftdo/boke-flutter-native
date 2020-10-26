import 'package:flutter/material.dart';
import 'package:oldbirds/ui/pages/answer/answer_page_state.dart';
import 'package:provider/provider.dart';
import 'package:progress_state_button/progress_button.dart';

class AnswerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnswerPageState>(
      create: (ctx) => AnswerPageState(),
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/answer_bg.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Consumer<AnswerPageState>(
            builder: (context, state, child) {
              if (state.isAsk) {
                return _askBody(state);
              } else {
                return _answerBody(state);
              }
            },
          ),
        ),
      ),
    );
  }

  Container _answerBody(AnswerPageState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 200),
            child: Text(
              '对于你的问题，神说',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "“",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: state.answer,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "”",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50, left: 16, right: 16),
            child: ProgressButton(
              minWidth: 120.0,
              progressIndicatorAligment: MainAxisAlignment.center,
              height: 50.0,
              radius: 25.0,
              padding: EdgeInsets.all(8),
              stateWidgets: {
                ButtonState.idle: Text(
                  "继续提问",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.loading: Text(
                  "  继续提问",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.fail: Text(
                  "失败",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.success: Text(
                  "成功",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              },
              stateColors: {
                ButtonState.idle: Colors.grey.shade400,
                ButtonState.loading: Colors.blue.shade300,
                ButtonState.fail: Colors.red.shade300,
                ButtonState.success: Colors.green.shade400,
              },
              onPressed: state.getAsk,
              state: state.inProgress ? ButtonState.loading : ButtonState.idle,
            ),
          ),
        ],
      ),
    );
  }

  Container _askBody(AnswerPageState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              '1. 请在心理思考一个封闭的问题\n例如：我需要这个东西吗？\n2. 闭上眼睛冥想 3 秒钟\n3. 睁开双眼点击答案按钮',
              style: TextStyle(
                fontSize: 18,
                height: 1.8,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, left: 16, right: 16),
            child: ProgressButton(
              minWidth: 120.0,
              progressIndicatorAligment: MainAxisAlignment.center,
              height: 50.0,
              radius: 25.0,
              padding: EdgeInsets.all(8),
              stateWidgets: {
                ButtonState.idle: Text(
                  "答案",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.loading: Text(
                  "  答案",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.fail: Text(
                  "失败",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.success: Text(
                  "成功",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              },
              stateColors: {
                ButtonState.idle: Colors.grey.shade400,
                ButtonState.loading: Colors.blue.shade300,
                ButtonState.fail: Colors.red.shade300,
                ButtonState.success: Colors.green.shade400,
              },
              onPressed: state.getAnswer,
              state: state.inProgress ? ButtonState.loading : ButtonState.idle,
            ),
          ),
        ],
      ),
    );
  }
}
