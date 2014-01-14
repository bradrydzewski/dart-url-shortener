import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';

import 'server.dart' as server;

void main() {
  useVMConfiguration();
  
  /**
   * The named method "thisMethodDNE" does not exist, therefore this test will 
   * throw an error. 
   */
  test('MethodDNEThrowsError', () {
    expect(thisMethodDNE(), null); 
  });
  
  /**
   * Test Hashing the given URL. 
   */
  group('HashURL', () {
    
    String URL = ''; 
    
    setUp(() {
      URL = 'http://www.meetup.com/gdg-silicon-valley/events/159082592/';
    });
    
    test('HashURLWillFail', () {
      expect(server.toHash(URL), null);
    });
    
    test('HashURLWillSucced', () {
      expect(server.toHash(URL), isNotNull);
      expect(server.toHash(URL), '287b6d95');
    });
  });
}