import 'package:flutter/material.dart';
import 'package:mumbai_machinetask/constant/sizedbox.dart';
import 'package:mumbai_machinetask/controller/task_controller.dart';
import 'package:mumbai_machinetask/helper/colors.dart';
import 'package:mumbai_machinetask/view/home_screeen.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final todo;
  const AddScreen({super.key, this.todo});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    final todoProvider = Provider.of<TaskProvider>(context, listen: false);
    if (todo != null) {
      todoProvider.isEditValueChange(true);
      final title = todo.title;
      final descriptio = todo.description;
      todoProvider.titleController.text = title;
      todoProvider.descriptionController.text = descriptio;
    } else {
      todoProvider.isEditValueChange(false);
      todoProvider.titleController.text = '';
      todoProvider.descriptionController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              provider.isEdit ? 'Edit Todo' : 'Add Todo',
              style: const TextStyle(
                color: cWhiteColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            centerTitle: true,
          ),
          body: Consumer<TaskProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  // padding: const EdgeInsets.all(20),
                  children: [
                    cHeight20,
                    TextField(
                      controller: provider.titleController,
                      decoration: const InputDecoration(hintText: "Title"),
                    ),
                    TextField(
                      controller: provider.descriptionController,
                      decoration: const InputDecoration(hintText: "Description"),
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: 6,
                    ),
                    cHeight5,
                    Row(
                      children: [
                        const Text('Deadline:'),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: provider.deadline,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != provider.deadline) {
                              provider.selectedDeadline(
                                provider.deadline = picked,
                              );
                            }
                          },
                        ),
                        Text('${provider.deadline.toLocal()}'.split(' ')[0]),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Expected Duration: "),
                        Slider(
                          thumbColor: cGreyColor300,
                          activeColor: cGreyColor300,
                          value: provider.expectedDuration.inHours.toDouble(),
                          min: 1,
                          max: 24,
                          divisions: 23,
                          label: '${provider.expectedDuration.inHours} hours',
                          onChanged: (value) {
                            provider.selectedExpectedDuration(
                              provider.expectedDuration =
                                  Duration(hours: value.toInt()),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            '${provider.expectedDuration.inHours} hour${provider.expectedDuration.inHours > 1 ? 's' : ''}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    cHeight20,
                    ElevatedButton(
                      onPressed: () {
                        if (provider.isEdit) {
                          // provider.updateTask(widget.todo);
                          // showSuccessMessage('Updation Success');
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //   builder: (context) => const HomeScreen(),
                          // ));
                        } else {
                          provider.addTask();
                          showSuccessMessage('Creation Success');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cCyanColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          provider.isEdit ? 'Update' : 'Submit',
                          style: const TextStyle(
                            color: cWhiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
