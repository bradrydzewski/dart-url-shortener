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
    }
  });

  // encode the JSON data
  InputElement uriInput = querySelector("#url");
  
  // POST the data to the server
  request.open("POST","/?url=${uriInput.value}", async:false); //"/?url=${urlClean}", async: false);
  request.send();
}


//void reverseText(MouseEvent event) {
//  var text = querySelector("#sample_text_id").text;
//  var buffer = new StringBuffer();
//  for (int i = text.length - 1; i >= 0; i--) {
//    buffer.write(text[i]);
//  }
//  querySelector("#sample_text_id").text = buffer.toString();
//}



//  var postTo = new Uri.http( window.location.host, "/", { "url" : url });
//var urlClean = Uri.encodeComponent(url);
//String jsonData = JSON.encode({ "url" : url });
//request.send(jsonData);

//void onDataLoaded(String responseText) {
//  var hash = responseText;
//  querySelector("#hash").text = hash;
//}