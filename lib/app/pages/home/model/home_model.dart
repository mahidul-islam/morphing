import 'dart:convert';

class TopicList {
  TopicList({
    this.count,
    this.topics,
  });

  int? count;
  List<Topic>? topics;

  factory TopicList.fromRawJson(String str) =>
      TopicList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopicList.fromJson(Map<String, dynamic> json) => TopicList(
        count: json["count"] == null ? null : json["count"],
        topics: json["topics"] == null
            ? null
            : List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "topics": topics == null
            ? null
            : List<dynamic>.from(topics!.map((x) => x.toJson())),
      };
}

class Topic {
  Topic({
    this.name,
    this.start,
    this.end,
    this.eventCount,
  });

  String? name;
  int? start;
  int? end;
  int? eventCount;

  factory Topic.fromRawJson(String str) => Topic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        name: json["name"] == null ? null : json["name"],
        start: json["start"] == null ? null : json["start"],
        end: json["end"] == null ? null : json["end"],
        eventCount: json["event_count"] == null ? null : json["event_count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "start": start == null ? null : start,
        "end": end == null ? null : end,
        "event_count": eventCount == null ? null : eventCount,
      };
}
