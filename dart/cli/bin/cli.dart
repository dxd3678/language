// dart:io 是 Dart SDK 中的一个核心库，它提供了处理文件、目录、套接字、HTTP 客户端和服务器等的 API。
import 'dart:io';

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

void searchWikipediaV2(List<String>? arguments) {
  final String articleTitle;

  // If the user didn't pass in arguments, request an article title.
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    // Await input and provide a default empty string if the input is null.
    articleTitle = stdin.readLineSync() ?? '';
  } else {
    // Otherwise, join the arguments into a single string.
    articleTitle = arguments.join(' ');
  }

  print('Current article title: $articleTitle');
}

// dart bin/cli.dart version
void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Hello, Dart!');
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  } else if (arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'search') {
    // final 变量只能设置一次，用于在代码中不再打算更改该变量的情况。
    // arguments.sublist(1) 创建一个新列表，其中包含 arguments 列表中除第一个元素（即第一个元素）之外的所有元素。
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipediaV2(inputArgs);
  } else {
    printUsage();
  }
}