// dart:io 是 Dart SDK 中的一个核心库，它提供了处理文件、目录、套接字、HTTP 客户端和服务器等的 API。
import 'dart:io';
import 'package:http/http.dart' as http;

const version = "0.0.1";

void printUsage() { // Add this new function
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
  );
}

void searchWikipedia(List<String>? arguments) {
  // dart bin/cli.dart search hello world
  // searchWikipedia received arguments: [hello, world]
  print('searchWikipedia received arguments: $arguments');
}

void searchWikipediaV2(List<String>? arguments) async {
  final String articleTitle;

  // If the user didn't pass in arguments, request an article title.
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    // Await input and provide a default empty string if the input is null.
    final inputFromStdin = stdin.readLineSync();

    // 例如，用户按下 Ctrl+D/Ctrl+Z 或空字符串，则打印一条消息并退出函数。
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article title provided. Exiting.');
      return; // Exit the function if no valid input
    }

    articleTitle = inputFromStdin;
  } else {
    // Otherwise, join the arguments into a single string.
    articleTitle = arguments.join(' ');
  }

  print('Looking up articles about "$articleTitle". Please wait.');

  // Call the API and await the result
  // var future = getWikipediaArticle(articleTitle);
  // print("dong something ...");
  // var articleContent = await future;
  // print(articleContent); // Print the full article response (raw JSON for now)

  var future1 = getWikipediaArticle('Dart');
  var future2 = getWikipediaArticle('Flutter');

  for (var i = 0; i < 5; i++) {
    print('Both requests sent! Waiting... $i');
    await Future.delayed(Duration(seconds: 1));
  }

  // 这两个 await 虽然看起来"阻塞"，但请求是并发的
  var result1 = await future1;
  var result2 = await future2;
  
  print('=== Both done ===');
  print(result1);
  print(result2);
}

// dart bin/cli.dart version
void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Hello, Dart!');
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  } else if (arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'wikipedia') {
    // final 变量只能设置一次，用于在代码中不再打算更改该变量的情况。
    // arguments.sublist(1) 创建一个新列表，其中包含 arguments 列表中除第一个元素（即第一个元素）之外的所有元素。
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipediaV2(inputArgs);
  } else {
    printUsage();
  }
}

// Future<String> 返回类型表示此函数最终会生成一个 String 结果，但不会立即生成，因为它是一个异步操作。
// async 关键字将函数标记为异步函数，允许在其中使用 await 。
Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );
  final response = await http.get(url); // Make the HTTP request

  if (response.statusCode == 200) {
    await Future.delayed(Duration(seconds: 10));
    return response.body; // Return the response body if successful
  }

  // Return an error message if the request failed
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}
