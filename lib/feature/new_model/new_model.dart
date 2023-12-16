import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sms_app/feature/home/home_view.dart';
import 'package:sms_app/product/model/filter_model.dart';
import 'package:sms_app/product/service/database_service.dart';

class NewModelView extends StatefulWidget {
  const NewModelView({super.key, this.remove = false, this.model});

  final bool remove;
  final FilterModel? model;

  @override
  State<NewModelView> createState() => _NewModelViewState();
}

class _NewModelViewState extends State<NewModelView> {
  late final TextEditingController number =
      TextEditingController(text: widget.model?.phone ?? '');
  late final TextEditingController filter =
      TextEditingController(text: widget.model?.filter ?? '');

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeView()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add a Filter'),
          actions: [
            if (widget.remove)
              IconButton(
                  onPressed: () async {
                    await DatabaseService.instance.delete(widget.model!.id);
                    if (!mounted) return;
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeView()));
                  },
                  icon: Icon(
                    Ionicons.trash_outline,
                    color: Colors.red.shade600,
                  ))
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: number,
                  keyboardType: TextInputType.phone,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Phone number to filter',
                    hintText: '5550035244',
                    border: OutlineInputBorder(),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: filter,
                  decoration: InputDecoration(
                    labelText: 'Message to filter',
                    hintText: 'test',
                    border: OutlineInputBorder(),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
                SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      DatabaseService.instance.put(widget.model != null
                          ? widget.model!
                              .copyWith(filter: filter.text, phone: number.text)
                          : FilterModel(
                              filter: filter.text, phone: number.text));
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeView()));
                    },
                    child: Text(widget.model != null ? 'Update' : 'Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
