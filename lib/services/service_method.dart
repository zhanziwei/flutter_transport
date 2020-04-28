import 'package:fluttertransport/config/service_url.dart';
import 'package:postgres/postgres.dart';

Future request(operation, {time}) async {
  var serviceURL = {
    "passTotalWeight": "select Cheak_Total_Weight_By_Time('$time');",
    "fiveCompany": "select * from Total_Weight_Rank_BY_Company('$time');",
    "totalAvgWeight": "select * from Avg_Weight ('$time');",
    "totalWeightByDay": "select * from Total_weight_BY_day('$time');",
    "originalTable": "select * from orders limit 50;",
  };
  print("进入request");
  try {
    var connection = new PostgreSQLConnection(db["host"], db["port"], db["db"], username: db["user"], password: db["password"]);
    await connection.open();
    List<List<dynamic>> results = await connection.query(serviceURL[operation]);
    return results;
  } catch (e) {
    return print("ERROR====================>$e");
  }
}