import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(App());
}
class App extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: apphome(),
    );
  }

}

class apphome extends StatefulWidget{







  @override
  State<apphome> createState() => _apphomeState();
}

class _apphomeState extends State<apphome> {
  String result="";
  List <Map<String,String>> sms=[];
  @override
  Widget build(BuildContext context) {



    String apiKey = "AIzaSyCyGclaTPoya-1lvyooUF86I9Se6QBNJIo"; // Replace with your Gemini API Key

    final GenerativeModel model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
    );

    Future<GenerateContentResponse> sendMessageToGemini(String userMessage) async {
      final content = [Content.text(userMessage)];
      final response = await model.generateContent(content);
      return response;
    }
    void receiveGeminiResponse(String userMessage) async {
      try {
        final response = await sendMessageToGemini(userMessage);
        setState(() {
          result= response.text ?? "⚠️ No response from Gemini.";

        });
      } catch (e) {

        setState(() {
          result = " Error: $e";

        });
      }
      setState(() {
        sms.add({'role':'assistant','text':result});
      });
    }

    final TextEditingController con = TextEditingController();



    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        shadowColor: Colors.purple[100],
        elevation: 20,

        title: Text("NAHI.AI"),
      // leading: Text(" DESIGNED  BY NAHID"),
       leadingWidth: 100,
       //leading: Icon(Icons.flutt),
        //centerTitle: true,
        actions: [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('DEVELOPED BY N A H I D   ',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,)
            ),
          ],

        ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(

          children: [
            Expanded(
              child: ListView.builder(
                itemCount: sms.length,
                itemBuilder: (BuildContext context, int index) {

                bool isuser=sms[index]['role']=='user';
                return Align(
                  alignment: isuser?Alignment.centerRight:Alignment.centerLeft,
                  child: Container(

                    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isuser?Colors.deepPurple:Colors.white70,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isuser?Colors.white:Colors.deepPurple,
                        width: 2,
                      ),

                    ),
                    child: Text(
                        sms[index]['text']??"",
                      style: TextStyle(
                        color: isuser?Colors.white:Colors.black,
                      ),
                    ),


                  ),
                );
              },
              ),
            ),
            SizedBox(height: 10,),

            Row(
              children: [
                Container(

                  height:50,
                  width: 300,
                  child: TextField(
                    controller: con,
                    decoration: InputDecoration(
                      label: Text("Enter Your Message"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      )
                    ),
                ),
                IconButton(onPressed: (){
                  setState(() {
                    sms.add({'role':'user','text':con.text});
                    receiveGeminiResponse(con.text);
                    con.clear();

                  });

                }, icon: Icon(Icons.send,color: Colors.deepPurple,))
              ],
            ),



          ],
        ),
      )
    );
  }
}

