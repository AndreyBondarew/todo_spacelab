import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:todo_spacelab/app/core/common/model/note_domain.dart';
import 'package:todo_spacelab/app/core/common/model/note_readonly.dart';
import 'package:todo_spacelab/app/viewmodel/note_viewmodel.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final NoteViewModel _viewModel = Injector().get<NoteViewModel>();
  final TextEditingController _editingController = TextEditingController();
  final List<NoteReadonlyModel> _notesList = [];
  late final StreamSubscription? _eventListenerSubscription;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _eventListenerSubscription = _viewModel.event.listen((event) => _eventDispatcher(event));
    _viewModel.load();
  }

  @override
  void dispose() {
    _editingController.dispose();
    _eventListenerSubscription?.cancel();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO-DO demo app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _inputForm(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Container(
                height: 2.0,
                color: Theme.of(context).dividerColor,
              ),
            ),
            Flexible(child: _buildNotesList()),
          ],
        ),
      ),
    );
  }

  Widget _inputForm() {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _editingController,
            onChanged: (val) => _setModifier(),
          ),
        ),
        IconButton(
          onPressed: _isButtonDisabled ? null : _saveNote,
          icon: Icon(
            Icons.add,
            color: _isButtonDisabled ? Theme.of(context).disabledColor : Colors.green,
          ),
        ),
      ],
    );
  }

  void _setModifier() {
    if (_editingController.text.isEmpty) {
      setState(() {
        _isButtonDisabled = true;
      });
    } else {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  void _saveNote() {
    _viewModel.save(NoteDomainModel(name: _editingController.text));
    setState(() {
      _editingController.text = '';
      _isButtonDisabled = true;
    });

    _viewModel.load();
  }

  Widget _buildNotesList() {
    if (_notesList.isEmpty) {
      return const Center(
        child: Text('Nothing'),
      );
    }
    return ListView.builder(
      itemBuilder: (ctx, index) => _itemBuilder(index),
      itemCount: _notesList.length,
    );
  }

  Widget _itemBuilder(int index) {
    return Dismissible(
      key: Key(_notesList[index].id),
      onDismissed: (direction) {
        _viewModel.delete(_notesList[index].id);
        _viewModel.load();
      },
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              //title: const Text("Confirm"),
              content: const Text("Are you sure to delete this task?"),
              actions: <Widget>[
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Yes"),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("No"),
                ),
              ],
            );
          },
        );
      },
      background: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          color: Theme.of(context).errorColor,
        ),
      ),
      child: Card(
        child: ListTile(
          title: Text(
            _notesList[index].name,
            style: TextStyle(
              decoration: _notesList[index].isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          leading: Checkbox(
            onChanged: (val) => setState(() {
              NoteDomainModel note = NoteDomainModel.fromMap(_notesList[index].toMap())..isDone = val!;
              _viewModel.save(note);
              _viewModel.load();
            }),
            value: _notesList[index].isDone,
          ),
        ),
      ),
    );
  }

  void _eventDispatcher(NoteListNotification event) {
    if (event is NoteListResultNotification) {
      setState(() {
        _notesList.clear();
        _notesList.addAll(event.noteList ?? []);
      });
    }
  }
}
