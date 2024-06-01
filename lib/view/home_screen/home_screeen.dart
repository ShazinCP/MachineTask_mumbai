import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mumbai_machinetask/controller/task_controller.dart';
import 'package:mumbai_machinetask/helper/colors.dart';
import 'package:mumbai_machinetask/model/task_model.dart';
import 'package:mumbai_machinetask/services/auth_services.dart';
import 'package:mumbai_machinetask/view/add_screen/add_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TaskProvider>(context, listen: false);
    provider.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Taskify",
          style: TextStyle(
            color: cWhiteColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 7,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: () => provider.fetchTasks(),
            child: Visibility(
              visible: provider.tasks.isNotEmpty,
              replacement: const Center(
                child: Text(
                  'No Item',
                  style: TextStyle(color: cGreyColor, fontSize: 19),
                ),
              ),
              child: ListView.builder(
                itemCount: provider.tasks.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final item = provider.tasks[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: cCyanColor,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(item.title),
                      subtitle: Text(formatDate(item.deadline)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: item.isComplete,
                            onChanged: (bool? value) {
                              if (value != null) {
                                setState(() {
                                  item.isComplete = value;
                                });
                              }
                            },
                          ),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {
                                navigateToEditPage(item);
                              } else if (value == 'delete') {
                                provider.deleteTask(item.id);
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Text("Edit"),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text("Delete"),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: cCyanColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddScreen(),
          ));
        },
        label: const Text("Add"),
      ),
    );
  }

  Future<void> navigateToEditPage(TaskModel item) async {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    final route = MaterialPageRoute(
      builder: (context) => AddScreen(todo: item),
    );
    await Navigator.push(context, route);
    provider.setLoading(true);
    provider.fetchTasks();
  }

  void logout() {
    final auth = AuthServices();
    auth.signOut();
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
