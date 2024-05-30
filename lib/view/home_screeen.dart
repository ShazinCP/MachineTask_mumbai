import 'package:flutter/material.dart';
import 'package:mumbai_machinetask/controller/task_controller.dart';
import 'package:mumbai_machinetask/helper/colors.dart';
import 'package:mumbai_machinetask/view/add_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   final provider = Provider.of<TaskProvider>(context, listen: false);
  //   super.initState();
  //   provider.fetchTask();
  // }

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
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: provider.fetchTask,
            child: Visibility(
              // visible: provider.items.isNotEmpty,
              replacement: const Center(
                child: Text(
                  'No Item',
                  style: TextStyle(color: cGreyColor, fontSize: 19),
                ),
              ),
              child: ListView.builder(
                // itemCount: provider.items.length,
                itemCount: 10,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  // final item = provider.items[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: cCyanColor,
                          child: Text('${index + 1}')),
                      title: Text("item.title!"),
                      subtitle: Text("item.description!"),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'edit') {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => AddScreen(todo: item),
                            // ));
                          } else if (value == 'delete') {
                            provider.deleteById("item.id!");
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

  Future<void> navigateToEditPage(Map item) async {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    final route = MaterialPageRoute(
      builder: (context) => AddScreen(todo: item),
    );
    await Navigator.push(context, route);
    provider.setLoading(true);
    provider.fetchTask();
  }

  // void showErrorMessage(String message) {
  //   final snackBar = SnackBar(
  //     content: Text(
  //       message,
  //       style: const TextStyle(color: cWhiteColor),
  //     ),
  //     backgroundColor: cRedColor,
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
