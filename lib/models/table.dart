class Table {
  final String name;
  final int x;
  final int y;
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
      x: json['x'] as int,
      y: json['y'] as int,
      directions: json['directions'] as String,
      guests: (json['guests'] as List).map((e) => e as String).toList(),
    );
  }
}
