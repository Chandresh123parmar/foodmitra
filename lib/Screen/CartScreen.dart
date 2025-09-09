import 'package:flutter/material.dart';
import 'package:foodmitra/widget/ContainerWidgets.dart';

import '../utils/FoodText.dart';
import '../widget/TextWidgets.dart';
import 'BottomBarNavigatorScreen.dart';
import 'HomeScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final height =  MediaQuery.of(context).size.height;
    final width =  MediaQuery.of(context).size.width/1.1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body:/*CartData.cartItems.isEmpty
          ? Center(
            child: TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Bottombarnavigatorscreen()));
                },
                child: text(
                    'Please add items',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.grey.shade500

                ),)
          )
          : ListView.builder(
        itemCount: CartData.cartItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(CartData.cartItems[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    CartData.cartItems.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),*/

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child:customContainer(
            width: width,
              height: height,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  text(
                      name,
                      fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                  text(
                      'Phone No : $phone_NO',
                      fontSize: 13 ,
                      fontWeight: FontWeight.bold
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                          'Name:',
                          fontSize: 13 ,
                          fontWeight: FontWeight.bold
                      ),
                      text(
                          'Date:',
                          fontSize: 13 ,
                          fontWeight: FontWeight.bold
                      ),
                    ],
                  ),
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                          'Address:',
                          fontSize: 13 ,
                          fontWeight: FontWeight.bold
                      ),
                      text(
                          'People No:',
                          fontSize: 13 ,
                          fontWeight: FontWeight.bold
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                          'Phone:',
                          fontSize: 13 ,
                          fontWeight: FontWeight.bold
                      ),
                      text(
                          'Shift:',
                          fontSize: 13 ,
                          fontWeight: FontWeight.bold
                      ),
                      text(
                          'Price:',
                          fontSize: 13 ,
                          fontWeight: FontWeight.bold
                      ),
                    ],
                  )
                ],
              ))
        ),
      )

    );
  }
}
