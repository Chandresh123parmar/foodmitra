import 'package:flutter/material.dart';

import '../utils/FoodText.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  final TextEditingController SearchBar = TextEditingController();
  @override
  Widget build(BuildContext context){
    final widget = MediaQuery.of(context).size.width/2.1;
    final hight = MediaQuery.of(context).size.height/15;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: TextField(
                controller: SearchBar,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade300)
                  ),
                  hintText: 'કેટેગરી માટે ખોજો',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,size: 30,color: Colors.grey.shade600,),
                  filled: true,
                  fillColor: Colors.grey.shade300
                ),
              )
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20),
              child: Text('કેટેગરીજ',style: TextStyle(fontSize: 25),),
            ),

            Expanded(
              child: Card(
                elevation: 1,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(widget, hight),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        onPressed: (){},
                        child: Text(Biting,style: TextStyle(fontSize: 20),)),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                           // minimumSize: Size(widget, hight),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        onPressed: (){},
                        child: Text(Soup,style: TextStyle(fontSize: 20),)),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}