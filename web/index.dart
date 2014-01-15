import 'dart:html';

void main() {

  querySelector("#btn")
    .onClick.listen(onClick);
}

void onClick(MouseEvent event) {  
  // create new xhr
  HttpRequest request = new HttpRequest();
  
  // add an event handler that is called when the request finishes
  request.onReadyStateChange.listen((_) {
    if (request.readyState == HttpRequest.DONE &&
        (request.status == 200 || request.status == 0)) {
      // write the URI to the page and display
      showText(request.responseText);
    }
  });
  
  // get the url field
  InputElement uriInput = querySelector("#url_long");
  
  // POST the data to the server
  request.open("POST","/?url=${uriInput.value}", async: false);
  request.send();
}

// constructs and displays the shortened
// hash as a fully qualified URI.
void showText(String hash) {
  var url = "${window.location.protocol}//${window.location.host}/${hash}";
  var urlShort = querySelector("#url_short")
    ..attributes["href"] = url
    ..text = url
    ..classes.remove("hidden");
}