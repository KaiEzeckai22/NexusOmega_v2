class Log {
  late final String title;
  late final String tags;
  late final String author;
  late final List<dynamic> content;
  late String id;

  Log(this.title, this.tags, this.content, this.author);

  Log.fromJson(Map json)
      : title = json['title'],
        tags = json['tags'],
        content = json['content'],
        author = json['author'],
        id = json['_id'];
  // add contact numbers

  Map toJson() {
    return {
      'title': title,
      'tags': tags,
      'content': content,
      'author': author,
    };
  }
}
