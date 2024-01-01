import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Exercise {
  String name;
  int difficulty;

  Exercise({required this.name, required this.difficulty});
}

class Screen3Page1 extends StatefulWidget {
  @override
  _Screen3Page1State createState() => _Screen3Page1State();
}

class _Screen3Page1State extends State<Screen3Page1> {
  List<Exercise> exercises = [];
  int maxDifficulty = 1;

  List<Exercise> getLongestIncreasingSequence() {
    List<Exercise> filteredExercises =
        exercises.where((exercise) => exercise.difficulty <= maxDifficulty).toList();

    if (filteredExercises.isEmpty) {
      return [];
    }

    List<int> dp = List.filled(filteredExercises.length, 1);
    for (int i = 1; i < filteredExercises.length; i++) {
      for (int j = 0; j < i; j++) {
        if (filteredExercises[i].difficulty > filteredExercises[j].difficulty &&
            dp[i] < dp[j] + 1) {
          dp[i] = dp[j] + 1;
        }
      }
    }
    int maxLength = dp.reduce((value, element) => value > element ? value : element);
    List<Exercise> sequence = [];
    for (int i = filteredExercises.length - 1; i >= 0 && maxLength > 0; i--) {
      if (dp[i] == maxLength) {
        sequence.insert(0, filteredExercises[i]);
        maxLength--;
      }
    }
    return sequence;
  }

  void _clearExercises() {
    setState(() {
      exercises.clear();
      saveExercises(); // Lưu danh sách bài tập sau khi xóa
    });
  }

  @override
  void initState() {
    super.initState();
    loadExercises(); // Tải danh sách bài tập khi ứng dụng khởi động
  }

  void _showAddExerciseDialog(BuildContext context) {
    String exerciseName = '';
    int exerciseDifficulty = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Thay thế BottomSheet bằng AlertDialog
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Tên bài tập'),
                      onChanged: (value) {
                        exerciseName = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Độ khó'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          exerciseDifficulty = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          exercises.add(Exercise(
                              name: exerciseName, difficulty: exerciseDifficulty));
                          saveExercises(); // Lưu danh sách bài tập sau khi thêm
                          Navigator.pop(context);
                        });
                      },
                      child: Text('Xác nhận'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildExerciseList() {
    return Expanded(
      child: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${exercises[index].name}'),
            subtitle: Text('Độ khó: ${exercises[index].difficulty}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  exercises.removeAt(index); // Xóa item tại index
                  saveExercises(); // Lưu danh sách bài tập sau khi xóa
                });
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mục tiêu tập luyện'),
          titleTextStyle:TextStyle(color: Color.fromRGBO(23, 43, 68, 1), fontWeight: FontWeight.bold,fontSize: 20),
          backgroundColor: Color(0xFFFFCC00),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Danh sách bài tập:',
                    style: TextStyle(color: Color.fromRGBO(23, 43, 68, 1), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _showAddExerciseDialog(context);
                    },
                  ),
                ],
              ),
              _buildExerciseList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Giới hạn độ khó:'),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Độ khó tối đa'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          maxDifficulty = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Hiển thị màn hình loading
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      await Future.delayed(Duration(seconds: 2)); // Thời gian chờ 2 giây (có thể thay đổi)
                      _showExercisePopup(context);
                    },
                    child: Text('Xác nhận'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showExercisePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Danh sách bài tập'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: getLongestIncreasingSequence().map((exercise) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${exercise.name} - Độ khó: ${exercise.difficulty}',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveExercises() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> exercisesData = exercises.map((exercise) {
      return '${exercise.name},${exercise.difficulty}';
    }).toList();
    await prefs.setStringList('exercises', exercisesData);
  }

  Future<void> loadExercises() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? exercisesData = prefs.getStringList('exercises');
    if (exercisesData != null) {
      exercises = exercisesData.map((data) {
        List<String> splitData = data.split(',');
        return Exercise(name: splitData[0], difficulty: int.parse(splitData[1]));
      }).toList();
    }
  }
}
