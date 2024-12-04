import 'package:flutter/material.dart';
import 'package:project/components/task.dart';
import 'package:project/data/task_dao.dart';
import 'package:project/data/task_inherit.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Nova tarefa',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: 650,
                width: 375,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'Insira o nome da Tarefa';
                          }
                          return null;
                        },
                        controller: nameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nome',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              int.parse(value) > 5 ||
                              int.parse(value) < 1) {
                            return 'Insira uma dificuldade entre 1 e 5';
                          }
                        },
                        keyboardType: TextInputType.number,
                        controller: difficultyController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Dificuldade',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor insira uma URL válida';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        controller: imageController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Imagem',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 72,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.blue)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageController.text,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/images/empty_image.png',
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TaskDao().save(Task(
                            nameController.text,
                            imageController.text,
                            int.parse(difficultyController.text),
                          ));

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Salvando nova tarefa...'),
                            ),
                          );

                          // Retorna um valor indicando que uma nova tarefa foi salva
                          Navigator.pop(context, true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Adicionar!'),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
