import '../../../services/ad/ad_manager.dart';
import 'drawing.dart';
import 'drawing_painter.dart';
import 'quiz_manager.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> implements QuizEventListener {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _level;

  Drawing _drawing;

  String _clue;

  BannerAd _bannerAd;

  InterstitialAd _interstitialAd;

  bool _isInterstitialAdReady;

  bool _isRewardedAdReady;

  @override
  void initState() {
    super.initState();

    QuizManager.instance
      ..listener = this
      ..startGame();

    _isInterstitialAdReady = false;

    _isRewardedAdReady = false;

    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );

    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );

    RewardedVideoAd.instance.listener = _onRewardedAdEvent;
    _loadBannerAd();
    _loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    '题目 $_level/5',
                    style: TextStyle(fontSize: 32),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlineButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          String _answer = '';

                          return AlertDialog(
                            title: Text('输入你的答案'),
                            content: TextField(
                              autofocus: true,
                              onChanged: (value) {
                                _answer = value;
                              },
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('提交'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  QuizManager.instance.checkAnswer(_answer);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      _clue,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(24),
                          child: CustomPaint(
                            size: Size(300, 300),
                            painter: DrawingPainter(
                              drawing: _drawing,
                            ),
                          ),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.all(16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        child: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              child: Text('跳过本题'.toUpperCase()),
              onPressed: () {
                QuizManager.instance.nextLevel();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    // COMPLETE: Return a FloatingActionButton if a Rewarded Ad is available
    return (!QuizManager.instance.isHintUsed && _isRewardedAdReady)
        ? FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('需要一个暗示?'),
                    content: Text('看广告获取一个暗示!'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('取消'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text('确定'),
                        onPressed: () {
                          Navigator.pop(context);
                          RewardedVideoAd.instance.show();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            label: Text('暗示'),
            icon: Icon(Icons.card_giftcard),
          )
        : null;
  }

  void _moveToHome() {
    Navigator.of(context).pop();
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // COMPLETE: Implement _loadBannerAd()
  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.top);
  }

  // COMPLETE: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    _interstitialAd.load();
  }

  // COMPLETE: Implement _loadRewardedAd()
  void _loadRewardedAd() {
    RewardedVideoAd.instance.load(
      targetingInfo: MobileAdTargetingInfo(),
      adUnitId: AdManager.rewardedAdUnitId,
    );
  }

  // COMPLETE: Implement _onInterstitialAdEvent()
  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        break;
      case MobileAdEvent.closed:
        _moveToHome();
        break;
      default:
      // do nothing
    }
  }

  // COMPLETE: Implement _onRewardedAdEvent()
  void _onRewardedAdEvent(RewardedVideoAdEvent event,
      {String rewardType, int rewardAmount}) {
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        setState(() {
          _isRewardedAdReady = true;
        });
        break;
      case RewardedVideoAdEvent.closed:
        setState(() {
          _isRewardedAdReady = false;
        });
        _loadRewardedAd();
        break;
      case RewardedVideoAdEvent.failedToLoad:
        setState(() {
          _isRewardedAdReady = false;
        });
        break;
      case RewardedVideoAdEvent.rewarded:
        QuizManager.instance.useHint();
        break;
      default:
      // do nothing
    }
  }

  @override
  void dispose() {
    // COMPLETE: Dispose BannerAd object
    _bannerAd?.dispose();
    // COMPLETE: Dispose InterstitialAd object
    _interstitialAd?.dispose();
    // COMPLETE: Remove Rewarded Ad event listener
    RewardedVideoAd.instance.listener = null;
    QuizManager.instance.listener = null;

    super.dispose();
  }

  @override
  void onWrongAnswer() {
    _showSnackBar('回答错误!');
  }

  @override
  void onNewLevel(int level, Drawing drawing, String clue) {
    setState(() {
      _level = level;
      _drawing = drawing;
      _clue = clue;
    });

    // COMPLETE: Load an Interstitial Ad
    if (level >= 3 && !_isInterstitialAdReady) {
      _loadInterstitialAd();
    }
  }

  @override
  void onLevelCleared() {
    _showSnackBar('干得漂亮!');
  }

  @override
  void onGameOver(int correctAnswers) {
    showDialog(
      context: _scaffoldKey.currentContext,
      builder: (context) {
        return AlertDialog(
          title: Text('游戏结束!'),
          content: Text('得分: $correctAnswers/5'),
          actions: <Widget>[
            FlatButton(
              child: Text('关闭'),
              onPressed: () {
                // COMPLETE: Display an Interstitial Ad
                if (_isInterstitialAdReady) {
                  _interstitialAd.show();
                }
                _moveToHome();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onClueUpdated(String clue) {
    setState(() {
      _clue = clue;
    });

    _showSnackBar('您还有一个线索！');
  }
}
