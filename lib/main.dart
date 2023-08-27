import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
QuizBrain quizBrain = QuizBrain();
void main() {
  print("Changes made by developer1_dev");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> scoreKeeper = [];
  int rightAnswer = 0;
  int wrongAnswer = 0;
  void  checkAnswer(bool userPickedAnswer){
          bool correctAnswer = quizBrain.getQuestionAnswer();

          setState(() {
            if(quizBrain.isFinished() == true){
              scoreKeeper = [];
              rightAnswer = 0;
              wrongAnswer = 0;
              quizBrain.reset();
              Alert(
                context: context,
                title: 'Finished',
                desc: 'The quiz is finished',
              ).show();
            }else{
              if(userPickedAnswer == correctAnswer){

                scoreKeeper.add(Icon(Icons.check,color: Colors.green,));
                rightAnswer++;
              }else{
                scoreKeeper.add(Icon(Icons.close,color: Colors.red,));
                wrongAnswer++;
              }
            }
            quizBrain.nextQuestion();
          });

  }
  Widget buildColumn(String txt,int count){
    return Padding(
      padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(txt,style: TextStyle(color: Colors.white,fontSize: 20),),
          Text('$count',style: TextStyle(color: Colors.white,fontSize: 20),)
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        buildColumn('Wright',rightAnswer),
                        buildColumn('Wrong',wrongAnswer)
                    ],
                  ),
                )),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )),
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FlatButton(
                      color: Colors.green,
                      onPressed: () {
                       checkAnswer(true);
                      },
                      child: Text(
                        'True',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FlatButton(
                      color: Colors.red,
                      onPressed: () {
                        checkAnswer(false);
                      },
                      child: Text(
                        'False',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                )),
            Row(children: scoreKeeper)
          ],
        ),
      ),
    );
  }
}
