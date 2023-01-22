

class NetworkInterface {

  final Function(dynamic data) onSuccess;
  final Function(Map errorMap) onError;

  NetworkInterface({required this.onSuccess, required this.onError});
}