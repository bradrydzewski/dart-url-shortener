import 'package:webdriver/pageloader.dart';
import 'package:webdriver/webdriver.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/compact_vm_config.dart';
import 'dart:io';

/**
 * These tests are not expected to be run as part of normal automated testing,
 * as they are slow and they have external dependencies.
 */
void main() {
  useCompactVMConfiguration();

  WebDriver driver;
  PageLoader loader;
  
  Duration TEN_SECONDS=new Duration(seconds:10);

  setUp(() => WebDriver.createDriver(desiredCapabilities: Capabilities.firefox)
        .then((_driver) {
          driver = _driver;
          loader = new PageLoader(driver);
          return driver.get("http://localhost:3000");
        }));

  tearDown(() => driver.quit());

  test('integration test', (){
    return driver.findElement(new By.id('url_long'))
        .then((elem)=>elem.sendKeys("https://www.dartlang.org/"))
        .then((elem)=>elem.attributes)
        .then((Attributes attrs){return attrs["value"]; })
        .then((attr)=>expect(attr, "https://www.dartlang.org/"))
        .then((_) => driver.findElement(new By.id('btn')))
        .then((elem)=>elem.click())
        .then((_) => sleep(TEN_SECONDS))
        .then((_) => driver.findElement(new By.id('url_short')))
        .then((elem)=>elem.click())
        .then((_) => sleep(TEN_SECONDS))
        .then((_) => driver.currentUrl)
        .then((url) => expect(url, "https://www.dartlang.org/"));
  });
}
