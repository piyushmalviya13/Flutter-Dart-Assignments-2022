class Node {
  final String _id;
  final String _name;
  final List<String> parent = [];
  final List<String> children = [];

  Node(this._id, this._name);

  String get id => _id;

  String get name => _name;
}
