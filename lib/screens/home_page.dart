import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/homeprovider.dart';
import '../screens/about_page.dart';
import '../utilities/app_style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat fn = DateFormat("M-dd-yyyy");
  String _selectedLocation = "ID";
  String datetime = '2-14-2020';
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    setState(() {
      datetime = fn.format(DateTime(now.year, now.month, now.day - 1));
    });
    Provider.of<HomeProvider>(context, listen: false).getHomeProvider();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat f = DateFormat("yyyy-MM-dd HH:mm:ss");
    final nf = NumberFormat("#,###");
    var home = Provider.of<HomeProvider>(context).home;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('lib/images/covid19.png', height: 20.0),
        backgroundColor: AppStyle.bg,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AboutPage()),
                );
              })
        ],
      ),
      body: Container(
        color: AppStyle.bg,
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            if (home != null)
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Icon(Icons.timer, color: AppStyle.txw),
                      SizedBox(width: 2),
                      Text(f.format(home?.lastUpdate),
                          style: TextStyle(color: AppStyle.txg)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  titleWidget('Confirmed',
                      nf.format(home?.confirmed?.value) ?? '', AppStyle.txw),
                  titleWidget('Recovered',
                      nf.format(home?.recovered?.value) ?? '', AppStyle.txg),
                  titleWidget('Deaths', nf.format(home?.deaths?.value) ?? '',
                      AppStyle.txr),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget titleWidget(title, subtitle, color) {
    return Container(
      height: 70,
      child: Card(
        color: Colors.blueGrey,
        margin: EdgeInsets.fromLTRB(0, 5, 160, 5),
        child: ListTile(
          title: Text(title, style: AppStyle.stdtw),
          subtitle: Text(subtitle,
              style: AppStyle.subtitleMain.copyWith(color: color)),
        ),
      ),
    );
  }
}
