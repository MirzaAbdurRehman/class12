import 'package:demo13/Model/userlistModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Welcome>? photos;

  

  Future<void> getUser() async{
    http.Response response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    print(response.statusCode);
    print(response.body);
    setState(() {
      photos = welcomeFromJson(response.body);
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: photos == null ? Center(child: CircularProgressIndicator(color: Colors.blue,)
            ):  Expanded(
              child: ListView.separated(
                itemBuilder: (context,index){
                  return ListTile(
                    leading: Image.network(photos![index].url.toString(),
                    errorBuilder: (context, index, stackTrace){
                      return Icon(Icons.person,color: Colors.blue,);
                    },
                    ),
                    title: Text("User Id: ${photos![index].id}",style: TextStyle(color: Colors.blue),),
                    subtitle: Text("Title: ${photos![index].title}",style: TextStyle(color: Colors.green),),
                    trailing: Icon(Icons.message,color: Colors.redAccent,),
                  );
                },
                 separatorBuilder: (context,index) {
                  return Divider(
                    thickness: 1,
                    color: Colors.grey,
                  );
                 },
                  itemCount: photos!.length),
                   ),
          ),
        ],
      ),
    );
  }
}