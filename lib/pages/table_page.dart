import 'package:flutter/material.dart';
import 'package:fluttertransport/services/service_method.dart';

class TablePage extends StatefulWidget {
  @override
  TablePageState createState() {
    return new TablePageState();
  }
}

class TablePageState extends State<TablePage>   with AutomaticKeepAliveClientMixin {
  Future _re;
  @override
  void initState() {
    super.initState();
    _re = _getTable();
  }


  Widget bodyData(List<Table> data) => SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
          onSelectAll: (b) {},
          columnSpacing: 15,
          //sortColumnIndex: 0,
          sortAscending: true,
          columns: <DataColumn>[
            DataColumn(
              label: Text("id"),
              numeric: false,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  data.sort((a, b) => a.id.compareTo(b.id));
                });
              },
            ),
            DataColumn(
              label: Text("公司名"),
              numeric: false,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  data.sort((a, b) => a.company.compareTo(b.company));
                });
              },
            ),
            DataColumn(
              label: Text("车牌号"),
              numeric: false,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  data.sort((a, b) => a.licenseplate.compareTo(b.licenseplate));
                });
              },
            ),
            DataColumn(
              label: Text("净重(吨)"),
              numeric: false,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  data.sort((a, b) => a.netweight.compareTo(b.netweight));
                });
              },
            ),
            DataColumn(
              label: Text("时间"),
              numeric: false,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  data.sort((a, b) => a.day.compareTo(b.day));
                });
              },
            ),
          ],
          rows: data
              .map(
                (table) => DataRow(
              cells: [
                DataCell(
                  Text(table.id),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(table.company),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(table.licenseplate),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(table.netweight),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(table.day),
                  showEditIcon: false,
                  placeholder: false,
                )
              ],
            ),
          )
              .toList()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("订单表", style: TextStyle(fontSize: 20),),
      ),
      body: FutureBuilder(
        future: _re,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List<Table> data = snapshot.data;
            return Container(
              child: bodyData(data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  Future _getTable() async {
    List<Table> tables = [];
    await request("originalTable",time: 50).then((val) {
      for(var item in val) {
        Table t = new Table(id: item[0].toString(), company: item[1].toString(), licenseplate: item[2].toString(), netweight: item[3].toStringAsFixed(3).toString(), day: item[4].toString().split('.')[0]);
        tables.add(t);
      }
    });

    return tables;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Table {
  String id;
  String company;
  String licenseplate;
  String netweight;
  String day;

  Table({this.company,this.day,this.id,this.licenseplate,this.netweight});
}
