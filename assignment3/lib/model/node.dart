class Node {
  final String id;
  final String name;
  List<Node> ancestor = [];
  List<Node> descendant = [];

  Node(this.id, this.name);
}
