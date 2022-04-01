// POST
// UPDATE
// DELETE
// https://newsapi.org/v2/everything?q=tesla&apiKey=a4c25c8b76f242c6863aedf4b21bfb3f
// https://newsapi.org/v2/everything?q=tesla&apiKey=a4c25c8b76f242c6863aedf4b21bfb3f
// GET
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=a4c25c8b76f242c6863aedf4b21bfb3f
// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=a4c25c8b76f242c6863aedf4b21bfb3f


// ignore_for_file: non_constant_identifier_names

// import '../../features/login/Screens/login_screen.dart';
// import '../cache/cache_helper.dart';


import '../../models/message model/message_model.dart';
import '../../models/post model/user_model.dart';

String? token = '';
String? recivedEmail ='';
String? uid ='';
 List<CreatePostModel> POSTS = [];
 List<MessageModel> MESSAGES = [];

// String? cacheImage ='';
// String? cacheCover ='';
// String? cacheName ='';
// String? cacheBio ='';

// signOut(context){
//
//   CacheHelper.removeData(key: 'token').then((value) {
//     if (value == true) {
//       navigateAndFinish(context, const LoginScreen());
//     }
//   });
// }