import 'package:flutter/material.dart';
import '../utils/FoodText.dart';
import '../widget/CartItem.dart';
import '../widget/TextWidgets.dart';
import 'BottomBarNavigatorScreen.dart';

class CartScreen extends StatefulWidget {
  final String categoryName;
  final List<String> subItems;
  const CartScreen({super.key, required this.categoryName, required this.subItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController peopleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController shiftController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    //  Group items by category
    final Map<String, List<CartItem>> groupedItems = {};
    for (var item in CartData.cartItems) {
      groupedItems.putIfAbsent(item.categoryName, () => []).add(item);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CartData.cartItems.isEmpty
          ? Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Bottombarnavigatorscreen()),
            );
          },
          child: text(
            'Please add items',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textColor: Colors.grey.shade500,
          ),
        ),
      )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: height/2.5,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                    ),
                    child: Column(
                      children: [
                        Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
                          child: Column(
                            children: [
                              Text(title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              Text(phone_NO,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 70),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Name : ',style: TextStyle(fontSize: 12),),
                                    Text('Date : ',style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 33),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Address : ',style: TextStyle(fontSize: 12),),
                                    Text('People No : ',style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 65),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Phone : ',style: TextStyle(fontSize: 12),),
                                    Text('Shift : ',style: TextStyle(fontSize: 12),),
                                    Text('Price : ',style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
              
                        Expanded(
                          child: ListView(
                            children: groupedItems.entries.map((entry) {
                          final category = entry.key;
                          final items = entry.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category header
                              Padding(
                                padding: const EdgeInsets.only(top: 10, left: 10),
                                child: Container(
                                  height: 30,
                                  width: width / 2.7,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.green.shade400),
                                  ),
                                  child: Center(child: Text(category,style: TextStyle(fontWeight: FontWeight.w600),)),
                                ),
                              ),
                              // Items under this category
                              ...items.asMap().entries.map((e) {
                                final item = e.value;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                        elevation: 0,
                                        margin: const EdgeInsets.all(8),
                                        child: SizedBox(
                                          width: width / 2,
                                          height: height / 22,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 5,),
                                              Text(item.subItem,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                              SizedBox(width: 10,),
                                              InkWell(
                                                onTap: (){
                                                      setState(() {
                                                        CartData.cartItems.remove(item);
                                                      });
                                                },
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius: BorderRadius.circular(25)
                                                  ),
                                                  child: Icon(Icons.close,color: Colors.black54,size: 15,),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){},
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade300,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Icon(Icons.edit_note_outlined),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                              Divider(color: Colors.grey,indent: 10,endIndent: 10,)
                            ],
                          );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () =>userDetailDialogs(),
                          style:ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            elevation: 0,
                            backgroundColor: Colors.lightBlue.shade50,
                            iconColor:Colors.blue,
                          ),
                          label: Text('EDIT',style: TextStyle(color: Colors.blue,fontSize: 11),),
                          iconAlignment: IconAlignment.end,
                          icon:Icon(Icons.edit_document,size: 18,) ,
                      ),
                      ElevatedButton.icon(
                        onPressed: () => userDetailDialogs(),
                        style:ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          elevation: 0,
                          backgroundColor: Colors.red.shade50,
                          iconColor:Colors.red,
                        ),
                        label: Text('PDF',style: TextStyle(color: Colors.red,fontSize: 11),),
                        iconAlignment: IconAlignment.end,
                        icon:Icon(Icons.picture_as_pdf_rounded,size: 18,) ,
                      ),
                      ElevatedButton.icon(
                        onPressed: (){},
                        style:ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          elevation: 0,
                          backgroundColor: Colors.green.shade50,
                          iconColor:Colors.green,
                        ),
                        label: Text('ADD NEW ITEM',style: TextStyle(color: Colors.green,fontSize: 11),),
                        iconAlignment: IconAlignment.end,
                        icon:Icon(Icons.edit_document,size: 18,) ,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
    );
  }
  Future<void> userDetailDialogs()async{
    String? errorMessage ;
    
      await showDialog(
          context: context,
          builder: (context){
            return StatefulBuilder(
                builder: (context, setState){
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text('User Profile'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          TextFormField(
                            controller: nameController,
                            decoration:InputDecoration(
                                labelText: 'Enter Name*',
                                labelStyle: TextStyle(color: Colors.grey)
                            ),

                          ),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration:InputDecoration(
                                labelText: 'Phone Number*',
                                labelStyle: TextStyle(color: Colors.grey)
                            ),
                          ),

                          TextFormField(
                            controller: peopleController,
                            keyboardType: TextInputType.number,
                            decoration:InputDecoration(
                                labelText: 'Number of People*',
                                labelStyle: TextStyle(color: Colors.grey)
                            ),
                          ),

                          TextFormField(
                            controller: dateController,
                            decoration:InputDecoration(
                                labelText: 'date*',
                                labelStyle: TextStyle(color: Colors.grey)
                            ),
                          ),

                          TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.streetAddress,
                            decoration:InputDecoration(
                                labelText: 'Address*',
                                labelStyle: TextStyle(color: Colors.grey)
                            ),
                          ),

                          TextFormField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration:InputDecoration(
                                labelText: 'Price*',
                                labelStyle: TextStyle(color: Colors.grey)
                            ),
                          ),

                          TextFormField(
                            controller: shiftController,
                            obscuringCharacter: '*',
                            decoration:InputDecoration(
                                labelText: 'Select Shift',
                                labelStyle: TextStyle(color: Colors.grey)
                            ),
                          ),

                          if(errorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(errorMessage!,style: TextStyle(color:Colors.red),),
                            ),

                        ],
                      ),
                    ),

                    actions: [

                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text('CLOSE')),
                      TextButton(
                          onPressed: (){
                            if(nameController.text.isEmpty &&
                                phoneController.text.isEmpty &&
                                peopleController.text.isEmpty &&
                                dateController.text.isEmpty &&
                                addressController.text.isEmpty &&
                                priceController.text.isEmpty &&
                                shiftController.text.isEmpty){
                              setState(() {
                                errorMessage = '*Please Fill all field !';
                              });
                            }else{
                              Navigator.pop(context);
                            }
                          },
                          child: Text('SAVE'))
                    ],
                  );
                });
          });
  }
}
