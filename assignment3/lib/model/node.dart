class Node {
  final String _id;
  final String _name;
  final List<String> _parent = [];
  final List<String> _children = [];

  Node(this._id, this._name);

  String get id => _id;

  String get name => _name;

  List<String> get parent => _parent;

  List<String> get children => _children;
}
