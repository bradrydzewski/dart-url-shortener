import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'dart:html';
import '../web/index.dart' as app;

main() {
  useHtmlEnhancedConfiguration();
  
  group("setting url hash", () {
    setUp((){
      app.main();
      app.showText("a7388fae");
    });

    test("url hash written to page", () {
      expect(querySelector("#url_short").text, "file:///a7388fae");  
    });
    test("url text visible on page", () {
      expect(querySelector("#url_short").classes.contains("hidden"), false);  
    });
    
  });
}