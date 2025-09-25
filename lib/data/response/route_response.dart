class RouteResponse {
  final String type;
  final List<double> bbox;
  final List<Feature> features;

  RouteResponse({
    required this.type,
    required this.bbox,
    required this.features,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    return RouteResponse(
      type: json['type'] as String,
      bbox: (json['bbox'] as List).map((e) => e as double).toList(),
      features: (json['features'] as List)
          .map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'bbox': bbox,
      'features': features.map((e) => e.toJson()).toList(),
    };
  }
}

class Feature {
  final List<double> bbox;
  final String type;
  final Properties properties;

  Feature({
    required this.bbox,
    required this.type,
    required this.properties,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      bbox: (json['bbox'] as List).map((e) => e as double).toList(),
      type: json['type'] as String,
      properties: Properties.fromJson(json['properties'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bbox': bbox,
      'type': type,
      'properties': properties.toJson(),
    };
  }
}

class Properties {
  final List<Segment> segments;
  final List<int> wayPoints;
  final Summary summary;

  Properties({
    required this.segments,
    required this.wayPoints,
    required this.summary,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      segments: (json['segments'] as List)
          .map((e) => Segment.fromJson(e as Map<String, dynamic>))
          .toList(),
      wayPoints: (json['way_points'] as List).map((e) => e as int).toList(),
      summary: Summary.fromJson(json['summary'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'segments': segments.map((e) => e.toJson()).toList(),
      'way_points': wayPoints,
      'summary': summary.toJson(),
    };
  }
}

class Segment {
  final double distance;
  final double duration;
  final List<Step> steps;

  Segment({
    required this.distance,
    required this.duration,
    required this.steps,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      distance: json['distance'] as double,
      duration: json['duration'] as double,
      steps: (json['steps'] as List)
          .map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      'steps': steps.map((e) => e.toJson()).toList(),
    };
  }
}

class Step {
  final double distance;
  final double duration;
  final int type;
  final String instruction;
  final String name;
  final List<int> wayPoints;
  final int? exitNumber;

  Step({
    required this.distance,
    required this.duration,
    required this.type,
    required this.instruction,
    required this.name,
    required this.wayPoints,
    this.exitNumber,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      distance: json['distance'] as double,
      duration: json['duration'] as double,
      type: json['type'] as int,
      instruction: json['instruction'] as String,
      name: json['name'] as String,
      wayPoints: (json['way_points'] as List).map((e) => e as int).toList(),
      exitNumber: json['exit_number'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      'type': type,
      'instruction': instruction,
      'name': name,
      'way_points': wayPoints,
      'exit_number': exitNumber,
    };
  }
}

class Summary {
  final double distance;
  final double duration;

  Summary({
    required this.distance,
    required this.duration,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      distance: json['distance'] as double,
      duration: json['duration'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
    };
  }
}
