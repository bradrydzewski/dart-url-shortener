import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';

import 'server.dart' as server;

void main() {
  useVMConfiguration();
  
  String URL = 'http://www.meetup.com/gdg-silicon-valley/events/159082592/';
  
  // Will err. For pitch purposes only. 
  test('HashURL_1', () {
    expect(server.toHash_1(URL), isNotNull); 
  });
      
  // Will fail. For pitch purposes only. 
  test('HashURL_2', () {
    expect(server.toHash_2(URL), isNotNull);
  });
  
  // Will succeed. 
  test('HashURL', () {
    expect(server.toHash(URL), isNotNull);
    expect(server.toHash(URL), '287b6d95');
  });
}