import 'dart:io';
import 'package:start/start.dart';
import 'package:redis_client/redis_client.dart';
import "package:crypto/crypto.dart";

void main() {
  // the port should be driven off of the environment
  // variable to enable heroku deployment.
  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 3000 : int.parse(portEnv);
  
  // the redis port and server should be driven off
  // the environment variable to enable REDIS TO GO hosting
  var redisEnv = Platform.environment['REDISTOGO_URL'];
  var redis = redisEnv == null ? "localhost:6379" : redisEnv;
  
  // global redis client
  RedisClient client;

  // initialize connection
  RedisClient.connect(redis)
    .then((c) => client=c);
  
  // start the web server
  start(public: 'build', port: port).then((Server app) {

    // handle a shortened URL link
    app.get('/:hash').listen((request) {
      // get the hash from the URL path
      String hash = request.param('hash');
      
      // TODO on error respond with 404 or bad request page
      
      // lookup the url for the hash and redirect
      client.get(hash).then((val) => request.response.redirect(val, 302));
    });
    
    // handle request to shorten a new url
    app.post("/").listen((request) {
      String url = request.param('url');
      String hash;

      // increment atomic redis counter
      client.incr("counter")
        // convert incremented value (integer) to a SHA hash
        .then((int val) => hash = toHash(val.toString()))
        // store the hash+url in the redis datastore
        .then((_) => client.set(hash, url))
        // return the hash in the response
        .then((_) => request.response.json(hash));

      // TODO make sure connection is closed
    });
  });
}

// Convert a string value into an 8 digit hex string
// using a SHA256 hashing algorithm.
String toHash(String value) {
  var sha256 = new SHA256();
  sha256.add(value.codeUnits);
  return CryptoUtils.bytesToHex(sha256.close()).substring(0, 8);
}