import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';

import 'server.dart' as server;

void main() {
  useVMConfiguration();
  
  String URL = 'http://www.meetup.com/gdg-silicon-valley/events/159082592/';
  
  test('HashURL', () {
    expect(server.toHash(URL), isNotNull);
    expect(server.toHash(URL), '287b6d95');
  });
}