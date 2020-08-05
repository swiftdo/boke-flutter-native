import 'package:flutter/material.dart';
import 'package:oldbirds/states/answer_page_state.dart';
import 'package:provider/provider.dart';

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
              if (state.empty) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      GestureDetector(
                        onTap: state.getAnswer,
                        child: Container(
                          margin: EdgeInsets.only(top: 40, left: 16, right: 16),
                          padding: EdgeInsets.only(
                            left: 80,
                            right: 80,
                            top: 15,
                            bottom: 15,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '答案',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
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
                        child: Text.rich(TextSpan(
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
                        )),
                      ),
                      GestureDetector(
                        onTap: state.onNext,
                        child: Container(
                          margin: EdgeInsets.only(top: 50, left: 16, right: 16),
                          padding: EdgeInsets.only(
                            left: 80,
                            right: 80,
                            top: 15,
                            bottom: 15,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '继续提问',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
