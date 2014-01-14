import 'dart:html';

void main() {

  querySelector("#shorten")
    .onClick.listen(onShorten);
}

void onShorten(MouseEvent event) {  
  // create new xhr
  HttpRequest request = new HttpRequest();
  
  // add an event handler that is called when the request finishes
  request.onReadyStateChange.listen((_) {
    if (request.readyState == HttpRequest.DONE &&
        (request.status == 200 || request.status == 0)) {
      // data saved OK.
      querySelector("#hash").text = window.location.protocol + "//" + window.location.host + "/" + request.responseText;

      // un-hide
      querySelector("#hash").classes.remove("hidden");
    }
  });
  
  // get the url field
  InputElement uriInput = querySelector("#url");
  
  // POST the data to the server
  request.open("POST","/?url=${uriInput.value}", async:false); //"/?url=${urlClean}", async: false);
  request.send();
}