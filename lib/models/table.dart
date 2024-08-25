class Table {
  final String name;
  final double x;
  final double y;
  final String directions;
  final List<String> guests;

  const Table({
    required this.name,
    required this.x,
    required this.y,
    required this.directions,
    required this.guests,
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      name: json['name'] as String,
      x: json['x'] as double,
      y: json['y'] as double,
      directions: json['directions'] as String,
      guests: (json['guests'] as List).map((e) => e as String).toList(),
    );
  }
}
