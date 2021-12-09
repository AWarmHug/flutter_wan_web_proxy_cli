import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_proxy/shelf_proxy.dart';
import 'package:shelf_packages_handler/shelf_packages_handler.dart';

void main(List<String> arguments) async {

  const BASE_URL_WAN_ANDROID = "https://www.wanandroid.com/";
  const BASE_URL_ZHIHU = "https://www.zhihu.com/api/";

  await proxy(BASE_URL_ZHIHU,4501);

  await proxy(BASE_URL_WAN_ANDROID,4500);

}

Future<void> proxy(String url,int port) async {
  var proxy = proxyHandler(url);

  /// 绑定本地端口，4500，转发到真正的服务器中
  var server = await shelf_io.serve(proxy, 'localhost', port);

  // 这里设置请求策略，允许所有
  server.defaultResponseHeaders.add('Access-Control-Allow-Origin', '*');
  server.defaultResponseHeaders.add('Access-Control-Allow-Credentials', true);
  print('Serving at http://${server.address.host}:${server.port}');
}