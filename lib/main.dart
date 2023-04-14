import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quizzler/quiz_brain.dart';
import 'question.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: quiz(),
    );
  }
}

class quiz extends StatefulWidget {
  const quiz({Key? key}) : super(key: key);

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  List<Widget> scorekeeper=[];

  void checkAnswer(bool userPickedAnswer) {
    bool? correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,
      //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.
      if (quizBrain.isFinished() == true) {
        //TODO Step 4 Part A - show an alert using rFlutter_alert,

        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        //Modified for our purposes:


          Alert(
            context: context,
            title: 'Finished!',
            desc: 'You\'ve reached the end of the quiz.',
          ).show();



        //TODO Step 4 Part C - reset the questionNumber,
        quizBrain.reset();

        //TODO Step 4 Part D - empty out the scoreKeeper.
        scorekeeper = [];
      }

      //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        if (userPickedAnswer == correctAnswer) {
          scorekeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }
  int track=0;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child:Center(
                child: Text(
                  quizBrain.getQuestionText() !,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextButton(
                    style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),

                  onPressed: (){
                    checkAnswer(true);

                  },
                  child: Text("true",
                    style: TextStyle(color: Colors.white),),

              ),
                )
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),

                      onPressed: (){
                        checkAnswer(false);



                        },
                      child: Text("FALSE",
                      style: TextStyle(color: Colors.white),
                      ),

                    ),
                  )
              ),

              Row(
                children: scorekeeper,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

