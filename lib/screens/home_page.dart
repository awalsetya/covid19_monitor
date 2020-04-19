import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/homeprovider.dart';
import '../providers/country_provider.dart';
import '../providers/province_provider.dart';
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
    Provider.of<CountryProvider>(context, listen: false).getCountryProvider();
    Provider.of<ProvinceProvider>(context, listen: false).getProvinceProvider(_selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat f = DateFormat("yyyy-MM-dd HH:mm:ss");
    final nf = NumberFormat("#,###");
    var home = Provider.of<HomeProvider>(context).home;
    var country = Provider.of<CountryProvider>(context).country;
    var province = Provider.of<ProvinceProvider>(context).province;
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
            SizedBox(height: 20),
            Card(
              color: Color(0xff3B4F55),
              child: Column(
                children: <Widget>[
                  if (country != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Theme(
                        data: ThemeData(canvasColor: AppStyle.bg),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text(
                            'Please choose a location',
                            style: TextStyle(color: AppStyle.bgl),
                          ),
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            print(newValue);
                            setState(() {
                              _selectedLocation = newValue;
                            });
                            Provider.of<ProvinceProvider>(context,
                                    listen: false)
                                .getProvinceProvider(newValue);
                          },
                          items: country.countries
                              .map(
                                (val) => DropdownMenuItem(
                                  value: val.iso2,
                                  child: Text(
                                    val.name,
                                    style: TextStyle(
                                      color: AppStyle.txg,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    confirmDetail(
                      province?.confirmed?.value?.toString(),
                      province?.recovered?.value?.toString(),
                      province?.deaths?.value?.toString(),
                    ),
                ],
              ),
            )
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

  Widget confirmDetail(confirm,recovered,death){
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Confirmed', style: AppStyle.stdtw),
              Padding(padding: AppStyle.pv10, child: Text(confirm ?? '',style: AppStyle.stdtb.copyWith(color:AppStyle.txw,),),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Recovered', style: AppStyle.stdtw),
              Padding(padding: AppStyle.pv10, child: Text(recovered ?? '',style: AppStyle.stdtb.copyWith(color:AppStyle.txg,),),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Deaths', style: AppStyle.stdtw),
              Padding(padding: AppStyle.pv10, child: Text(death ?? '',style: AppStyle.stdtb.copyWith(color:AppStyle.txr,),),
              ),
            ],
          ),
        )
      ],
    );
  }
}
