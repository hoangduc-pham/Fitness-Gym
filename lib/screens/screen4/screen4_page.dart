import 'package:flutter/material.dart';


class Screen4Page extends StatefulWidget {
  @override
  _Screen4PageState createState() => _Screen4PageState();
}

class _Screen4PageState extends State<Screen4Page> {
  late Graph graph;
  late List<List<int>> result;
  int selectedVertex = 0; // Biến lưu trữ đỉnh được chọn
  final Map<int, Offset> nodeCoordinates = {
    0: const Offset(50, 50), // Đỉnh 0
    1: const Offset(150, 100), // Đỉnh 1
    2: const Offset(250, 80), // Đỉnh 2
    3: const Offset(200, 200), // Đỉnh 3
    4: const Offset(300, 200), // Đỉnh 4
    5: const Offset(120, 265), // Đỉnh 5
    6: const Offset(250, 300), // Đỉnh 6
    7: const Offset(30, 220),
    8: const Offset(90, 350),
    9: const Offset(60, 100),
    // Thêm các đỉnh khác ở đây...
  };

  final TextEditingController textController = TextEditingController();
  int shortestDistance = 0;

  @override
  void initState() {
    super.initState();

    graph = Graph(10); // Thay đổi số lượng đỉnh thành 7

    graph.addEdge(0, 1, 2);
    graph.addEdge(0, 2, 4);
    graph.addEdge(1, 2, 2);
    graph.addEdge(1, 3, 3);
    graph.addEdge(2, 3, 3);
    graph.addEdge(2, 4, 3);
    graph.addEdge(3, 4, 2);
    graph.addEdge(1, 5, 4);
    graph.addEdge(4, 5, 5);
    graph.addEdge(4, 6, 2);
    graph.addEdge(6, 8, 4);
    graph.addEdge(5, 8, 1);
    graph.addEdge(5, 7, 2);
    graph.addEdge(7, 8, 3);
    graph.addEdge(1, 7, 4);
    graph.addEdge(7, 9, 3);

    result = graph.minGraph();
  }
  final Map<int, String> vertexNames = {
    0: 'Hai Bà\nTrưng',
    1: 'Thanh\nXuân',
    2: 'Đống\nĐa',
    3: 'Tây\nHồ',
    4: 'Hoàng\nMai',
    5: 'Ba\nĐình',
    6: 'Hà\nĐông',
    7: 'Cầu\nGiấy',
    8: 'Mỹ\nĐình',
    9: 'Hoàn\nKiếm',
    // Thêm các tên đỉnh khác ở đây...
  };
  final Map<int, String> vertexNames2 = {
    0: 'Quận Hai Bà Trưng',
    1: 'Quận Thanh Xuân',
    2: 'Quận Đống Đa',
    3: 'Quận Tây Hồ',
    4: 'Quận Hoàng Mai',
    5: 'Quận Ba Đình',
    6: 'Quận Hà Đông',
    7: 'Quận Cầu Giấy',
    8: 'Quận Mỹ Đình',
    9: 'Quận Hoàn Kiếm',
    // Thêm các tên đỉnh khác ở đây...
  };
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void findShortestDistance(int vertex) {         //tìm và cập nhật thông tin
    if (vertex >= 0 && vertex < graph.vertices) { // về khoảng cách ngắn nhất từ
      shortestDistance = result[0][vertex];// đỉnh xuất phát đến một đỉnh được chọn
      selectedVertex = vertex;
    } else {
      shortestDistance = -1;
      selectedVertex = -1;
    }
    setState(() {});
  }

  void handleDropdownChange(int? value) {
    if (value != null) {
      findShortestDistance(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<int> verticesList = List.generate(10, (index) => index);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tối ưu đường đi'),
        backgroundColor: Color(0xFFCC66CC),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Nhập điểm đến:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 20,
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButton<int>(
                      hint: const Text('Chọn điểm đích'),
                      value: selectedVertex != 0 ? selectedVertex : null,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      underline: SizedBox(),
                      onChanged: (int? value) {
                        if (value != null) {
                          findShortestDistance(value);
                          handleDropdownChange;
                        }
                      },
                      items: verticesList.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            '${vertexNames2[value]}',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
              ],
            ),
          ),

          const SizedBox(height: 16.0),
          shortestDistance >= 0
              ? Text(
            'Tổng quãng đường di chuyển là $shortestDistance km',
            style: const TextStyle(fontSize: 16),
          )
              : const Text(
            'Đồ thị có chu trình âm',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            flex: 3,
            child: CustomPaint(
              painter: GraphPainter(result, graph.edges, nodeCoordinates, selectedVertex, vertexNames ),
            ),
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset('assets/images/map.png'),
          ),
        ],
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<List<int>> result;
  final List<Edge> edges;
  final Map<int, Offset> nodeCoordinates;
  final int selectedVertex;
  final Map<int, String> vertexNames;
  GraphPainter(this.result, this.edges, this.nodeCoordinates, this.selectedVertex, this.vertexNames);

  @override
  void paint(Canvas canvas, Size size) {
    for (var edge in edges) {
      Paint linePaint = Paint()
        ..strokeWidth = 14.0
        ..color = Color.fromRGBO(23, 43, 68, 1).withOpacity(0.5);

      if (result[0][selectedVertex] ==
          result[0][edge.src] + edge.weight + result[edge.dest][selectedVertex]) {
        linePaint.color = Colors.redAccent.withOpacity(0.8);
        linePaint.strokeWidth = 14.0;
      }


      double x1 = nodeCoordinates[edge.src]!.dx; //Lấy tọa độ của đỉnh nguồn (edge.src)
      double y1 = nodeCoordinates[edge.src]!
          .dy; // và đỉnh đích (edge.dest) của cạnh để vẽ.
      double x2 = nodeCoordinates[edge.dest]!.dx;
      double y2 = nodeCoordinates[edge.dest]!.dy;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);

      double textX = (x1 + x2) /
          2; //Tính toán vị trí trung điểm giữa hai đỉnh để đặt văn bản hiển thị trọng số của cạnh.
      double textY = (y1 + y2) / 2;
      TextSpan span = TextSpan(
        style: const TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),
        text: '${edge.weight}',
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset(textX - tp.width / 2, textY - tp.height / 2),
      );
    }
    for (var node in nodeCoordinates.entries) {
      Paint nodePaint = Paint()
        ..color = Color.fromRGBO(23, 43, 68, 1);
      if (node.key == selectedVertex) {
        nodePaint.color = Colors.redAccent;
      }

      canvas.drawCircle(
        Offset(node.value.dx, node.value.dy),
        25,
        nodePaint,
      );

      TextSpan nameSpan = TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        text: '${vertexNames[node.key]}',
      );
      TextPainter nameTp = TextPainter(
        text: nameSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      nameTp.layout();

      // Điều chỉnh vị trí hiển thị tên sao cho nằm ở trung tâm của vòng tròn đỉnh
      double textX = node.value.dx - nameTp.width / 2;
      double textY = node.value.dy - nameTp.height / 2;

      nameTp.paint(
        canvas,
        Offset(textX, textY),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Edge {
  final int src;
  final int dest;
  final int weight;

  Edge(this.src, this.dest, this.weight);
}

class Graph {               //Đây là lớp đại diện cho cấu trúc dữ liệu đồ thị.
  final int vertices; //Thuộc tính vertices: Lưu trữ số lượng đỉnh trong đồ thị.
  late List<Edge> edges; //Biến edges: Lưu trữ danh sách các cạnh trong đồ thị.
  late List<List<int>> dist;//Biến dist: Lưu trữ ma trận khoảng cách giữa các đỉnh.
  // ngoại trừ khoảng cách từ một đỉnh đến chính nó (dist[i][i] = 0).
  Graph(this.vertices) {
    edges = [];
    dist = List.generate(vertices, (_) => List.filled(vertices, 999));
    for (int i = 0; i < vertices; i++) {
      dist[i][i] = 0;
    }
  }

  void addEdge(int src, int dest, int weight) {
    dist[src][dest] = weight;
    edges.add(Edge(src, dest, weight));
  }

  List<List<int>> minGraph() {   //Sử dụng thuật toán Floyd-Warshall để tính toán ma
    for (int k = 0; k < vertices; k++) { // trận khoảng cách ngắn nhất giữa tất cả các cặp đỉnh trong đồ thị.
      for (int i = 0; i < vertices; i++) {// Duyệt qua các cặp đỉnh và cập nhật khoảng cách nếu
        for (int j = 0; j < vertices; j++) { // có đường đi ngắn hơn thông qua một đỉnh trung gian k.
          if (dist[i][k] + dist[k][j] < dist[i][j]) {// Kiểm tra xem có chu trình âm không bằng cách xem có
            dist[i][j] = dist[i][k] + dist[k][j];// đỉnh nào có khoảng cách âm đến chính nó hay không.
          } // Nếu có, đồ thị chứa chu trình âm và trả về một danh sách rỗng.
        }
      }
    }
    // Kiểm tra chu trình âm
    for (int i = 0; i < vertices; i++) {
      if (dist[i][i] < 0) {
        // Có chu trình âm
        return [];
      }
    }
    return dist;
  }
}
