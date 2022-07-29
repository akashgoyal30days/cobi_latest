import 'package:Cobi/Constants/constants.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future centreAPI(String url, FormData fromfile) async {
  final dio = Dio();
  SharedPreferences userdetails = await SharedPreferences.getInstance();
  var user = userdetails.getString('userid').toString();
  if (user != "null") {
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Client-ID': SecureConst.ClientID,
      'Client-Secret': SecureConst.Clientsecret,
      'Auth-Token': userdetails.getString('token').toString(),
      'uid': user,
      'cid': userdetails.getString('comapny_id').toString()
    };
  } else {
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Client-ID': SecureConst.ClientID,
      'Client-Secret': SecureConst.Clientsecret,
    };
  }
  Response response = await dio.post(
    SecureConst.baseurl + url,
    data: fromfile,
    onSendProgress: (received, total) {
      if (total != -1) {
        // // debugPrint((received / total * 100).toStringAsFixed(0) + '%');
      }
    },
  );
  // // debugPrint(response.data.toString());
  var convertedDatatoJson = response.data;
  return convertedDatatoJson;
}
//
// class registerApi {
//   void register() async {
//     try {
//       FormData formData = FormData();
//       formData = FormData.fromMap({
//         "industry_type": dropdownvalue.toString(),
//         "company_name": companynamecontroller.text.toString(),
//         "company_address": companyadresscontroller.text.toString(),
//         "name": applicantnamecontroller.text.toString(),
//         "designation": designationcontroller.text.toString(),
//         "mobile_no": mobilenocontroller.text.toString(),
//         "email_id": emailcontroller.text.toString(),
//       });
//
//       var rsp = await centreAPI("api/register", formData);
//       // // debugPrint(rsp.toString());
//       if (rsp.containsKey('status')) {
//
//         if (rsp['status'].toString() == "true") {
//
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               backgroundColor: Colors.black,
//               behavior: SnackBarBehavior.floating,
//               content: Text("Registration Successful")));
//
//         } else if (rsp['status'].toString() == "false") {
//           if (rsp['error'].toString() == "invalid_auth") {}
//         } else if (rsp['status'].toString() == "already_exist") {}
//       }
//     } catch (error, stacktrace) {
//       // // debugPrint('Stacktrace: ' + stacktrace.toString());
//       // // debugPrint(error.toString());
//     }
//   }
// }

// class updatecompanydetailsApi {
//   void updatecompanydetails() async {
//     try {
//       FormData formData = FormData();
//       formData = FormData.fromMap({
//         "industry_type": industrytypevalue,
//         "comp_constitution": constitutionalue,
//         "company_name": Cnamecontroller.text.toString(),
//         "company_pan": Cpancontroller.text.toString(),
//         "company_gstn": Cgstnocontroller.text.toString(),
//         "company_address": Caddresscontroller.text.toString(),
//         "district": districtvalue.toString(),
//         "state": statevalue.toString(),
//         "area_id": areavalue.toString(),
//       });
//       // debugPrint(Cindustrytypecontroller.text.toString());
//       // debugPrint(Cnamecontroller.text.toString());
//       // debugPrint(Cpancontroller.text.toString());
//       // debugPrint(Cgstnocontroller.text.toString());
//       // debugPrint(Caddresscontroller.text.toString());
//       var rsp = await centreAPI("api/editcompanydetails", formData);
//       // debugPrint(rsp.toString());
//       if (rsp.containsKey('status')) {
//         if (rsp['status'].toString() == "1") {
//         } else if (rsp['status'].toString() == "0") {
//           if (rsp['error'].toString() == "invalid_auth") {}
//         } else if (rsp['status'].toString() == "already_exist") {}
//       }
//     } catch (error, stacktrace) {
//       // debugPrint('Stacktrace: ' + stacktrace.toString());
//       // debugPrint(error.toString());
//     }
//   }
// }

class getpersonaldocsApi {
  List personaldoclist = [];
  bool showloader = true;
  void getpersonaldocs() async {
    showloader = true;
    try {
      FormData formData = FormData();

      var rsp = await centreAPI("api/getpersonaldocs", formData);

      // // debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        showloader = false;
        if (rsp['status'].toString() == "1") {
          personaldoclist = rsp["data"];
        } else if (rsp['status'].toString() == "0") {
          if (rsp['error'].toString() == "invalid_auth") {}
        } else if (rsp['status'].toString() == "already_exist") {}
      }
    } catch (error) {
      showloader = false;
      // // debugPrint('Stacktrace: ' + stacktrace.toString());
      // // debugPrint(error.toString());
    }
  }
}

mixin list {
  List personaldoclist = [];
  bool showloader = true;
  Future getpersonaldocs() async {
    showloader = true;
    try {
      FormData formData = FormData();

      var rsp = await centreAPI("api/getpersonaldocs", formData);

      // // debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        showloader = false;
        if (rsp['status'].toString() == "1") {
          return rsp['data'];
        } else {
          return rsp;
        }
      }
    } catch (error, stacktrace) {
      showloader = false;
      // // debugPrint('Stacktrace: ' + stacktrace.toString());
      // // debugPrint(error.toString());
      return {"error": error.toString(), "stack": stacktrace.toString()};
    }
  }

  Future getcompanydocs() async {
    showloader = true;
    try {
      FormData formData = FormData();

      var rsp = await centreAPI("api/getcompanydocs", formData);

      // // debugPrint(rsp.toString());
      if (rsp.containsKey('status')) {
        showloader = false;
        if (rsp['status'].toString() == "1") {
          return rsp['data'];
        } else {
          return rsp;
        }
      }
    } catch (error, stacktrace) {
      showloader = false;
      // // debugPrint('Stacktrace: ' + stacktrace.toString());
      // debugPrint(error.toString());
      return {"error": error.toString(), "stack": stacktrace.toString()};
    }
  }
}
