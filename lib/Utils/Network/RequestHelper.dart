import 'package:basicproduct/Utils/Network/NetworkInterface.dart';
import 'package:dio/dio.dart';

class RequestHelper {
  static get(
      {required String url, required NetworkInterface networkInterface}) async {
    try {
      Response response = await Dio().get(url);
      networkInterface.onSuccess(response.data);
    } on DioError catch (de) {
      Map p = {
        "type": "dio",
        "status": de.response!.statusCode ?? 0,
        "message": de.response!.statusMessage,
      };
      networkInterface.onError(p);
    } catch (e) {
      Map p = {
        "type": "normal",
        "status": 0,
        "message": e.toString(),
      };
      networkInterface.onError(p);
    }
  }

  static post(
      {required String url,
      required Map data,
      required NetworkInterface networkInterface}) async {
    try {
      Response response = await Dio().post(url, data: data);
      networkInterface.onSuccess(response.data);
    } on DioError catch (de) {
      Map p = {
        "type": "dio",
        "status": de.response!.statusCode ?? 0,
        "message": de.response!.statusMessage,
      };
      networkInterface.onError(p);
    } catch (e) {
      Map p = {
        "type": "normal",
        "status": 0,
        "message": e.toString(),
      };
      networkInterface.onError(p);
    }
  }
}
