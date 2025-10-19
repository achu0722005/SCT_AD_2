import 'package:flutter/material.dart';
import 'package:todo_list/end.dart';
void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF4d5f70),
      ),
      home: todohomescreen(),
    );
  }
}

class todohomescreen extends StatefulWidget {
  const todohomescreen({super.key});

  @override
  State<todohomescreen> createState() => _todohomescreenState();
}

class _todohomescreenState extends State<todohomescreen> {
  final color_appbar = Color(0xFF3d4c5a);
  List<bool> ischecked = List.generate(5, (_)=>false);
  List<String> task = List.generate(5, (index)=>"Task${index+1}");
  void _editTaskDialog(int index){
    TextEditingController controller = TextEditingController(text: task[index]);
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Color(0xff3d4c5d),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Edit Task"
          ),
          content: TextField(
            controller: controller,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: "edit your tasks",
              helperStyle: TextStyle(color:Colors.white),
          )
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("cancel",style: TextStyle(color: Colors.white),)),
            ElevatedButton(onPressed: (){
              setState(() {
                task[index]=controller.text;
              });
            }, child: Text("Save",style: TextStyle(color: Colors.white),))
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 100,
        titleSpacing: 23,
        backgroundColor: color_appbar,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "My Tasks",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> endscreen()));
            },
            tooltip: "Information",
            icon: Icon(Icons.info_outline, size: 30, color: Colors.white),
          ),
        ],
      ),
      body: Stack(
        children: [
          if(task.isEmpty)
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 200,
              height: 300,
              color: Color(0xFF4d5f70),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No tasks yet!",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Add one below.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/clipboard.png',
                      width: 100,
                      height: 100,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                      child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: Card(
                          color: Colors.white,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Dismissible(
                              key: Key(task[index] + index.toString()),
                                direction: DismissDirection.startToEnd,
                              background: Container(
                                color: Colors.redAccent,
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.delete_forever,color: Colors.white,),
                              ),
                              onDismissed: (direction){
                                setState(() {
                                  task.removeAt(index);
                                  ischecked.removeAt(index);
                                });
                              },
                              child: ListTile(
                                leading: InkWell(
                                  onTap: (){

                                    setState(() {
                                      ischecked[index]=!ischecked[index];
                                    });
                                  },

                                  child: Image.asset(ischecked[index]
                                    ?'assets/images/check.png':
                                      'assets/images/uncheck.png',
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                                title: Text(
                                  task[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    decoration: ischecked[index]?TextDecoration.lineThrough:TextDecoration.none,
                                  ),
                                ),
                                trailing: InkWell(
                                  onTap: (){
                                    _editTaskDialog(index);
                                  },
                                  child: Image.asset(
                                    ischecked[index]?
                                    'assets/images/edit.png':
                                    'assets/images/unedit.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Color(0xFF4d5f70), height: 0);
                  },
                  itemCount: task.length,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              task.add("new task");
              ischecked.add(false);
            });
          },
          tooltip: "Add your task",
          child: Icon(Icons.add, size: 40, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          splashColor: Colors.cyanAccent,
          backgroundColor: Colors.cyan,
          hoverColor: Colors.red,
          elevation: 10,
          highlightElevation: 20,
        ),
      ),
    );
  }
}
