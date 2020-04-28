import 'package:flutter/material.dart';
import 'package:fluttertransport/services/service_method.dart';

class TablePage extends StatefulWidget {
  @override
  TablePageState createState() {
    return new TablePageState();
  }
}

class TablePageState extends State<TablePage> {
  Future re;
  List data;
  @override
  void initState() {
    super.initState();
    re = request("originalTable",'').then((val){
      data = val;
      print(data);
      //print(data.);
    });
  }
  List<Table> tables = [

    Table(id: "1", company: "阿斯顿asda接", licenseplate: "黑C·72V94",netweight: "13",day: "2020-04-20 12:12:39"),
    Table(id: "2", company: "迎撒旦", licenseplate: "黑A·73V51",netweight: "23",day: "2020-04-21 12:12:39"),
    Table(id: "3", company: "啊实打实", licenseplate: "黑C·13242",netweight: "33",day: "2020-04-22 12:12:39"),
];
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      columnSpacing: 18,
      //sortColumnIndex: 0,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("id"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              tables.sort((a, b) => a.id.compareTo(b.id));
            });
          },
        ),
        DataColumn(
          label: Text("公司名"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              tables.sort((a, b) => a.company.compareTo(b.company));
            });
          },
        ),
        DataColumn(
          label: Text("车牌号"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              tables.sort((a, b) => a.licenseplate.compareTo(b.licenseplate));
            });
          },
        ),
        DataColumn(
          label: Text("净重(吨)"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              tables.sort((a, b) => a.netweight.compareTo(b.netweight));
            });
          },
        ),
        DataColumn(
          label: Text("时间"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              tables.sort((a, b) => a.day.compareTo(b.day));
            });
          },
        ),
      ],
      rows: tables
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
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单表"),
      ),
      body: Container(
        child: bodyData(),
      ),
    );
  }
}

class Table {
  String id;
  String company;
  String licenseplate;
  String netweight;
  String day;

  Table({this.company,this.day,this.id,this.licenseplate,this.netweight});
}


