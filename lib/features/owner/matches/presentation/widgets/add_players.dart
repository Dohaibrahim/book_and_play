import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:flutter/material.dart';

class AddPlayersWidget extends StatefulWidget {
  const AddPlayersWidget({super.key, required this.onPlayersChanged});
  final void Function(List<String>) onPlayersChanged;

  @override
  State<AddPlayersWidget> createState() => _AddPlayersWidgetState();
}

class _AddPlayersWidgetState extends State<AddPlayersWidget> {
  final List<TextEditingController> _controllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    _controllers[0].addListener(_notifyParent);
  }

  void _addPlayerField() {
    final lastController = _controllers.last;
    final lastText = lastController.text.trim();

    if (lastText.isEmpty) {
      TopSnackBar.show(
        context,
        title: 'Warning',
        message: 'Please enter a Player ID before adding a new one.',
        contentType: ContentType.warning,
        color: Colors.orange,
      );
      return;
    }

    final controller = TextEditingController();
    controller.addListener(_notifyParent);

    setState(() {
      _controllers.add(controller);
    });

    _notifyParent();
  }

  void _notifyParent() {
    final currentPlayers = _controllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();
    widget.onPlayersChanged(currentPlayers);
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.removeListener(_notifyParent);
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._controllers.map((controller) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                      controller: controller,
                      hintText: 'Add Player ID',
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _addPlayerField,
                    icon: const Icon(Icons.add_circle_outline, size: 30),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
