import 'dart:collection';
import 'package:assignment3/model/node.dart';

class Tree {
  HashMap<String, Node> _tree = HashMap();

  bool checkNodeId(String nodeId) {
    return _tree.containsKey(nodeId);
  }

  Iterable<String> getNodeIds() {
    return _tree.keys;
  }

  String addNode(String nodeId, String nodeName) {
    if (checkNodeId(nodeId)) {
      return 'Node with id $nodeId already exists';
    }
    Node node = Node(nodeId, nodeName);
    _tree[nodeId] = node;

    return 'Node Added';
  }

  String removeNode(String nodeId) {
    if (!checkNodeId(nodeId)) {
      return 'Enter valid existing node id';
    }
    //removing dependancy from children of provided node
    _tree[nodeId]!.children.forEach((childNodeId) {
      removeDependency(nodeId, childNodeId);
    });

    //removing dependancy from parent of provided node
    _tree[nodeId]!.parent.forEach((parentNodeId) {
      removeDependency(parentNodeId, nodeId);
    });

    _tree.remove(nodeId);

    return 'Node removed';
  }

  String addDependency(String parentNodeId, String childNodeId) {
    if (!checkNodeId(childNodeId) || !checkNodeId(parentNodeId)) {
      return 'Enter valid node ids';
    }
    if (_tree[parentNodeId]!.children.contains(childNodeId)) {
      return 'Dependency already exists';
    }
    //adding dependancy to parent node
    _tree[parentNodeId]!.children.add(childNodeId);
    //adding dependancy to child node
    _tree[childNodeId]!.parent.add(parentNodeId);

    if (checkLoopBfs(childNodeId) || checkLoopBfs(parentNodeId)) {
      removeDependency(parentNodeId, childNodeId);
      return 'This is an invalid dependency';
    }

    return 'Dependency Added';
  }

  String removeDependency(String parentNodeId, String childNodeId) {
    if (!checkNodeId(childNodeId) || !checkNodeId(parentNodeId)) {
      return 'Enter valid node ids';
    }

    //removing dependancy from parent node
    bool foundChild = _tree[parentNodeId]!.children.remove(childNodeId);

    //removing dependancy from child node
    bool foundParent = _tree[childNodeId]!.parent.remove(parentNodeId);

    if (foundParent && foundChild) {
      return 'Dependency Removed';
    } else {
      return 'Seems the dependancy entered doesn\'t exist';
    }
  }

  List<String> getParents(String nodeId) {
    if (checkNodeId(nodeId)) {
      return _tree[nodeId]!.parent;
    }

    throw Exception('Enter valid node id');
  }

  List<String> getChildren(String nodeId) {
    if (checkNodeId(nodeId)) {
      return _tree[nodeId]!.children;
    }

    throw Exception('Enter valid node id');
  }

  //get ancestors using breadth first search for the given node
  List<String> getAncestors(String nodeId) {
    List<String> ancestors = [];
    Queue<Node> bfsQueue = Queue();
    bfsQueue.add(_tree[nodeId]!);

    while (bfsQueue.isNotEmpty) {
      Node currentNode = bfsQueue.removeFirst();
      ancestors.add(currentNode.id);
      currentNode.parent.forEach((nodeId) {
        bfsQueue.add(_tree[nodeId]!);
      });
    }
    ancestors.remove(nodeId);
    ancestors.sort();
    return ancestors;
  }

  //get descendants using breadth first search for the given node
  List<String> getDescendants(String nodeId) {
    List<String> descendants = [];
    Queue<Node> bfsQueue = Queue();
    bfsQueue.add(_tree[nodeId]!);

    while (bfsQueue.isNotEmpty) {
      Node currentNode = bfsQueue.removeFirst();
      descendants.add(currentNode.id);
      currentNode.children.forEach((nodeId) {
        bfsQueue.add(_tree[nodeId]!);
      });
    }
    descendants.remove(nodeId);
    descendants.sort();
    return descendants;
  }

  //get if loop exists in the graph currently using breadth first search for the given node
  bool checkLoopBfs(String nodeId) {
    Queue<Node> bfsQueue = Queue();
    bfsQueue.add(_tree[nodeId]!);

    Set<String> visited = Set();

    while (bfsQueue.isNotEmpty) {
      Node currentNode = bfsQueue.removeFirst();
      if (visited.contains(currentNode.id)) {
        return true;
      }
      visited.add(currentNode.id);
      currentNode.parent.forEach((nodeId) {
        if (!visited.contains(nodeId)) {
          bfsQueue.add(_tree[nodeId]!);
        }
      });
      currentNode.children.forEach((nodeId) {
        if (!visited.contains(nodeId)) {
          bfsQueue.add(_tree[nodeId]!);
        }
      });
    }
    return false;
  }
}
