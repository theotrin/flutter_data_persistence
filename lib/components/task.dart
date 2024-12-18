import 'package:flutter/material.dart';
import 'package:project/components/difficulty.dart';
import 'package:project/data/task_dao.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  const Task(this.nome, this.foto, this.dificuldade, {Key? key})
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assertOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  int level = 1;

  void levelUp() {
    setState(() {
      level++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue,
              ),
              height: 140,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black12,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: ClipRRect(
                            child: assertOrNetwork()
                                ? SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.asset(
                                      widget.foto,
                                      fit: BoxFit.cover,
                                      excludeFromSemantics: true,
                                    ))
                                : Image.network(
                                    widget.foto,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Difficulty(widget.dificuldade),
                          // vai ser um novo componente.
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right:
                                8.0), // Ajustando o padding para evitar overflow
                        child: SizedBox(
                          height: 48, // Mantém o botão com tamanho consistente
                          width: 48,
                          child: ElevatedButton(
                            onPressed: levelUp,
                            onLongPress: () {
                              TaskDao().delete(widget.nome);
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  EdgeInsets.zero, // Remove padding interno
                              shape: CircleBorder(), // Botão circular
                            ),
                            child: const Icon(
                              Icons.arrow_drop_up,
                              size: 28, // Ajusta o tamanho do ícone
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Container(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: Colors.white,
                          value: widget.dificuldade > 0
                              ? ((level / widget.dificuldade) / 10)
                              : 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Nivel: $level',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
