class DataResult<T>{
  T data;
  bool error;
  String errorMessage;

  DataResult({this.error, this.data, this.errorMessage});
}