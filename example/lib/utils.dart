import 'dart:math';

getRandomHeight(){
  var baseUrl  = "https://via.placeholder.com";
  var randomWidth = Random().nextInt(300 - 64) + 64;
  var randomHeight = Random().nextInt(300 - 64) + 64;
  return "$baseUrl/${randomWidth}x$randomHeight";
}
getRandomWidthHeightImage(){
  var baseUrl  = "https://via.placeholder.com";
  var randomWidth = Random().nextInt(300 - 64) + 64;
  var randomHeight = Random().nextInt(300 - 64) + 64;
  return [randomWidth,randomHeight,"$baseUrl/${randomWidth}x$randomHeight"];
}