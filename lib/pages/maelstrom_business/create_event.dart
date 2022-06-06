import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/application_bloc.dart';
import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/firestore_bloc.dart';
import 'package:maelstrom/bloc/storage.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/date_time_picker.dart';
import 'package:maelstrom/widgets/image_picker.dart';
import 'package:maelstrom/widgets/tag_picker.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:maelstrom/widgets/form_input.dart';
// import 'package:maelstrom/widgets/utils.dart';

// class HomePage extends BasePage {
class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final FirestoreService _firestoreService = FirestoreService();
  final Storage _firestoreStorage = Storage();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  String imagePathController = '';
  String imageNameController = '';
  List tagsController = [];
  TimeOfDay? timeController;
  DateTime? dateController;
  bool promoteController = false;

  // final bool isBusiness;

  // _CreateEventPageState(this.isBusiness);

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      FormInputText(
                        nameController,
                        'Son nom',
                        (value) => value != null && value.length < 4
                            ? "Le nom de votre évènement doit faire au moins 4 characters"
                            : null,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 20),
                      FormInputText(
                          descriptionController,
                          'Sa description',
                          (value) => value != null && value.length < 5
                              ? 'La description de votre évènement doit faire au moins 5 characters'
                              : null,
                          keyboardType: TextInputType.multiline),
                    ],
                  )),
              SizedBox(height: 20),
              ImagePicker(setImageControllers, imagePathController,
                  imageNameController),
              SizedBox(height: 20),
              TagPicker(
                setTagController,
                removeTagController,
                tagsController
                    .map((e) => MultiSelectItem(e, e['name']))
                    .toList(),
              ),
              SizedBox(height: 20),
              DateTimePicker(true, setDateController, dateController, "La date",
                  ThemeColors.principaleBusinessColor),
              SizedBox(height: 20),
              DateTimePicker(false, setTimeController, timeController,
                  "L'heure", ThemeColors.principaleBusinessColor),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                      fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return ThemeColors.principaleBusinessColor;
                        }
                        return ThemeColors.grayColor;
                      }),
                      value: promoteController,
                      onChanged: (bool? value) {
                        setState(() {
                          promoteController = value!;
                        });
                      }),
                  SizedBox(height: 20),
                  BaseText(
                    TextType.bodyText,
                    "Mettre en avant cet évènement?",
                  )
                ],
              ),
              SizedBox(height: 20),
              BaseButton(ButtonsType.big, () => submitEvent(pageBloc),
                  "Créer l'évènement", [
                ThemeColors.principaleBusinessColor,
                ThemeColors.radientBusinessColor
              ]),
              SizedBox(height: 20),
            ],
          ),
        )));
  }

  submitEvent(pageBloc) async {
    var hour = timeController?.hour;
    var minute = timeController?.minute;
    var dateTimeController = dateController?.add(Duration(
        hours: hour != null ? hour : 0, minutes: minute != null ? minute : 0));
    var timestampController = Timestamp.fromDate(
        dateTimeController != null ? dateTimeController : DateTime.now());
    var businessId = FirebaseAuth.instance.currentUser!.uid;

    print('hello');

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (imagePathController == '') {
      createError('Veuillez selectionner une image.');
      return;
    } else if (tagsController.length <= 0) {
      createError('Veuillez selectionner au moins un tag.');
      return;
      // } else if (tagsController.length >= 3) {
      //   createError('Ne pas seléctionner plus de 3 tags');
      //   setTagController([]);
      //   return;
    } else if (dateController == null) {
      createError('Veuillez selectionner une date');
      return;
    } else if (dateTimeController!.compareTo(DateTime.now()) < 0) {
      createError('Veuillez selectionner une date dans le future');
      return;
    } else if (timeController == null) {
      createError('Veuillez selectionner une heure');
      return;
    }

    final currentEvent = EventModel(
        idBusiness: businessId,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        tags: tagsController,
        date: timestampController,
        promote: promoteController,
        imageName: imageNameController);

    // _firestoreStorage.uplodFile(imagePathController, imageNameController);
    // _firestoreService.createEvent(currentEvent);

    // pageBloc.setChangePage(PageType.businessEvent);
  }

  void setDateController(value) => setState(() => dateController = value);
  void setTimeController(value) => setState(() => timeController = value);
  void setTagController(value) => setState(() => tagsController = value);
  void setImageControllers(imagePath, imageName) => setState(() => {
        imagePathController = imagePath,
        imageNameController = imageName,
      });
  void removeTagController(value) =>
      setState(() => tagsController.remove(value));

  createError(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: BaseText(TextType.bodyBoldText, message),
      backgroundColor: ThemeColors.errorColor,
    ));
  }
}
