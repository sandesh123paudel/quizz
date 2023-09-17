import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());



class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body:  SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  void checkAnswer(bool userPickedAnswer)
  {

    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if(quizBrain.isFinished()==true) {
          Alert(
            context: context,
            type: AlertType.success,
            title: 'Finished',
            desc: 'Quiz Questions has been completed)',

            buttons: [
              DialogButton(
                child: Text(
                  "Close"
                ),
                onPressed: () =>SystemNavigator.pop(),
                color: Colors.red,
              ),
              DialogButton(child: Text("Restart"), onPressed: ()=>Navigator.pop(context),color: Colors.green,)
            ]

          ).show();

          quizBrain.reset();

          scoreKeeper = [];
        }

    else{
    if (userPickedAnswer == correctAnswer) {
      scoreKeeper.add(Icon(Icons.check,color: Colors.green,));
    } else {
      scoreKeeper.add(Icon(Icons.close,color: Colors.red,));
    }
      quizBrain.nextQuestion();
    }
    });

  }






  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      //TextAlign:TextAlign.center;
                    ),
                  ),
                ),
              ),
              onTap: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: () {
                checkAnswer(false);

              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

_onBasicAlertPressed(context)
{
  Alert(
    context: context,
    title: "Quiz Completed",
    desc: "All Questions of this round has been completed"

  ).show();
}

