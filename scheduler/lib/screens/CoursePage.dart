import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/utils/courseModel.dart';
import 'package:scheduler/utils/courseTile.dart';
import 'package:scheduler/utils/databaseHelper.dart';
import 'package:scheduler/utils/databaseManager.dart';
// ignore: unused_import
import 'package:scheduler/utils/routes.dart';
import 'package:scheduler/utils/theme.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:intl/date_symbol_data_local.dart';

class CoursePage extends StatefulWidget{

  @override
  State<CoursePage> createState() => _CoursePageState();
}
databaseManager? database=databaseHelper.database;


class _CoursePageState extends State<CoursePage> {
  String day=DateFormat('EEEE').format(DateTime.now());
  String currTime=DateFormat('jm').format(DateTime.now());

   loadData() async {
    var db = database;
    if (db != null) {
      databaseHelper.futureCourseList = db.getCourses(day);
    }
    setState(() {});
  }
  @override
  void initState(){
    super.initState();
    database=databaseManager();
    loadData();
   }
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0) , // here the desired height
            child: AppBar(
              title: Center(child:  Text("NassauLab",style: TextStyle(color:Themes.darkBlue,fontSize: 23,fontWeight: FontWeight.w900), )),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(80))),
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Icon(Icons.upcoming,color: Themes.darkBlue,),
                  Icon(Icons.done_all_rounded,color: Themes.darkBlue,),
                ],
              ),
            )
        ),

        body:  TabBarView(
          children: [

            courseList(),
            courseListPast()
          ],
        ),
      ),
    );


  }
}
// Upcoming Lecture List
class courseList extends StatelessWidget {
 @override
  Widget build(BuildContext context){
    return Column(
      children: [
    Padding(padding: EdgeInsets.only(top:15),
                child: Text("Próximas aulas:",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Themes.darkBlue,

                  ),
                ),
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Themes.yellow1,
                    Themes.yellow2,
                  ]
                )
              ),
                child: FutureBuilder(
                future: databaseHelper.futureCourseList,
                builder:(context,AsyncSnapshot<List<Course>> snapshot){
                  if(!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(color: Themes.darkBlue,));
                  }

                  var list=snapshot.data!.where((element) =>((double.parse(element.hour)+((double.parse(element.min)/60)))>=((double.parse(DateFormat("H").format(DateTime.now())))+((double.parse(DateFormat.m().format(DateTime.now())))/60) ))).toList();
                  list.sort((a,b)=>((double.parse(a.hour)+((double.parse(a.min))/60)).compareTo((double.parse(b.hour)+((double.parse(b.min))/60)))));

                  return list.isEmpty? Center(child: Text("Sem aulas no momento, aproveite!",style: TextStyle(fontSize: 15),)) :ListView.builder(
                      // shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return CourseTile(course: list[index]);
                      },
                    );
                    },
              ),
            ),
          ),
        ),
      ],
    );

  }
}

// Past Lecture List
class courseListPast extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
    Padding(padding: EdgeInsets.only(top:15),
              child: Text("Aulas passadas:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Themes.darkBlue,

                ),
              ),
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      colors: [
                        Themes.yellow1,
                        Themes.yellow2,
                      ]
                  )
              ),
              child: FutureBuilder(
                future: databaseHelper.futureCourseList,
                builder:(context,AsyncSnapshot<List<Course>> snapshot){
                  if(!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(color: Themes.darkBlue,));
                  }
                  var list=snapshot.data!.where((element) =>((double.parse(element.hour)+((double.parse(element.min)/60)))<((double.parse(DateFormat("H").format(DateTime.now())))+((double.parse(DateFormat.m().format(DateTime.now())))/60) ))).toList();
                  list.sort((a,b)=>((double.parse(b.hour)+((double.parse(b.min))/60)).compareTo((double.parse(a.hour)+((double.parse(a.min))/60)))));

                  return list.isEmpty? Center(child: Text("Sem aulas passadas no momento"),): ListView.builder(
                    // shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return CourseTile(course: list[index]);
                    },
                  );

                },
              ),
            ),
          ),
        ),
      ],
    );

  }
}