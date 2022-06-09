import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.gif'),
            fit: BoxFit.fill
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200.0,
                            alignment: Alignment.bottomCenter,
                            child: Text('HIGH 0r LOW',
                            style: TextStyle(fontSize: 40.0, color: Colors.cyanAccent,fontFamily: 'pok', fontWeight: FontWeight.w700),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                            alignment: Alignment.bottomCenter,
                            child: Text('CARD GAME',
                            style: TextStyle(fontSize: 30.0, color: Colors.limeAccent,fontFamily: 'mm', fontWeight: FontWeight.w700),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 300.0,
                            alignment: Alignment.bottomCenter,
                            child: RaisedButton(
                              child: Container(
                                height: 60.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                  image:DecorationImage(
                                    image: AssetImage('images/start.jpg'),
                                    fit: BoxFit.contain
                                  ),
                                ),
                              ),
                              onPressed: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Startgame()),
                         );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ),     
    );
  }
}

class Startgame extends StatefulWidget {
  const Startgame({ Key? key }) : super(key: key);

  @override
  State<Startgame> createState() => _StartgameState();
}

int randomNum( int min, int max){
  int random =min + Random().nextInt(max - min);
  return random;
}
String randomstring (int len){
  var ran = Random();
  const chars = ('CDHS');
  return List.generate(len, (index) => chars[ran.nextInt(chars.length)]).join();
}
var prev_number_value = [randomNum(1, 13),0,0,0,0,0];
var prev_letter_value = [randomstring(1),'C','C','C','C','C'];
int cardnumber = 0;
var cardletter = 'C';
int score = 0;

void passnumber(){
  prev_number_value[5] = prev_number_value[4];
  prev_number_value[4] = prev_number_value[3];
  prev_number_value[3] = prev_number_value[2];
  prev_number_value[2] = prev_number_value[1];
  prev_number_value[1] = prev_number_value[0];
  prev_number_value[0] = cardnumber;
}
void passletter(){
  prev_letter_value[5] = prev_letter_value[4];
  prev_letter_value[4] = prev_letter_value[3];
  prev_letter_value[3] = prev_letter_value[2];
  prev_letter_value[2] = prev_letter_value[1];
  prev_letter_value[1] = prev_letter_value[0];
  prev_letter_value[0] = cardletter;
}
void pass(){
  prev_number_value[5] = 0;
  prev_number_value[4] = 0;
  prev_number_value[3] = 0;
  prev_number_value[2] = 0;
  prev_number_value[1] = 0;
  prev_letter_value[5] = 'C';
  prev_letter_value[4] = 'C';
  prev_letter_value[3] = 'C';
  prev_letter_value[2] = 'C';
  prev_letter_value[1] = 'C';
}
void continue_(){
  cardnumber = 0;
  cardletter = 'C';
}
 void showcard(){
   prev_number_value[0] = randomNum(1, 13);
   prev_letter_value[0] = randomstring(1);  
 }
void opencard(){
  if(score == 0){
    continue_();
    pass();
    showcard();
  }
} 
class _StartgameState extends State<Startgame> {
  @override
  Widget build(BuildContext context) {
    
    int cardnumber1 = prev_number_value[0];
    var cardletter1 = prev_letter_value[0];
    int cardnumber2 = prev_number_value[1];
    var cardletter2 = prev_letter_value[1];
    int cardnumber3 = prev_number_value[2];
    var cardletter3 = prev_letter_value[2];
    int cardnumber4 = prev_number_value[3];
    var cardletter4 = prev_letter_value[3];
    int cardnumber5 = prev_number_value[4];
    var cardletter5 = prev_letter_value[4];
    int cardnumber6 = prev_number_value[5];
    var cardletter6 = prev_letter_value[5];

  void continuee(BuildContext context){
    var alertdialog = AlertDialog(
      title: Text('Correct Guess!'),
      content: FlatButton(
        child: const Text('Continue', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.white),
        ),
        color: const Color.fromARGB(255, 16, 150, 20),
        onPressed: (){
          Navigator.pop(context);
          setState((){
            passnumber();
            passletter();
            continue_();
          });
        },
      ),
    );
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return alertdialog;
      }
    );
  }

 void tryagain(BuildContext context){
  var alertdialog = AlertDialog(
    title: const Text("Wrong Guess!",),
    content: FlatButton(
      child: const Text('Try Again',style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.white),
      ),
      color: const Color.fromARGB(255, 16, 150, 20),
      onPressed: (){
        Navigator.pop(context);
        setState((){
          opencard();
        });
      },
    ),
  );
  showDialog(
    context: context, 
    builder: (BuildContext context){
      return alertdialog;
      }
    );
  }
  
  void lessequal(){
    if(cardnumber <= prev_number_value[0]){
      score++;
      Future.delayed(Duration(milliseconds: 1000),(){
        continuee(context);
      });
    }
    else{
      score = 0;
      Future.delayed(Duration(milliseconds: 1000),(){
        tryagain(context);
      });
    }
  }
  
  void greater(){
    if(cardnumber > prev_number_value[0]){
      score++;
      Future.delayed(Duration(milliseconds: 1000),(){
        continuee(context);
      });
    }
    else {
      score = 0;
      Future.delayed(Duration(milliseconds: 1000),(){
        tryagain(context);
      });
    }
  }
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/neon.jpg'),
          fit: BoxFit.cover
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 0.0),
        child: Column(
          children: [
            Text('Score: $score',style: TextStyle(fontSize: 30.0,color: Colors.white),),
            SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/$cardnumber2$cardletter2.png'),
                    ),
                  ),
                ),
                Container(
                  height: 120.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/$cardnumber3$cardletter3.png'),
                    ),
                  ),
                ),
                Container(
                  height: 120.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/$cardnumber4$cardletter4.png'),
                    ),
                  ),
                ),
                Container(
                  height: 120.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/$cardnumber5$cardletter5.png'),
                    ),
                  ),
                ),
                Container(
                  height: 120.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/$cardnumber6$cardletter6.png'),
                    ),
                  ),
                ), 
              ]
            ),
            SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/$cardnumber1$cardletter1.png'),
                    ),
                  ),
                ),
                SizedBox(width: 50.0,),
                Container(
                  height: 150.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/$cardnumber$cardletter.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: FlatButton(
                    child: Text('<=',style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.normal, color: Colors.white),
                    ),
                    color: Color.fromARGB(255, 16, 150, 20),
                    onPressed: (){
                      setState(() {
                        cardnumber = randomNum(1, 13);
                        cardletter = randomstring(1);
                        lessequal();
                      });
                    },
                  ),
                ),
                SizedBox(width: 30.0,),
                Container(
                  child: FlatButton(
                    child: Text('>',style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.normal, color: Colors.white),
                    ),
                    color: Color.fromARGB(255, 16, 150, 20),
                    onPressed: (){
                      setState(() {
                        cardnumber = randomNum(1, 13);
                        cardletter = randomstring(1);
                        greater();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100.0,
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    color: Color.fromARGB(255, 16, 150, 20),
                    child: Text('Back Game',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                    onPressed: () { 
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
  );
 }
}