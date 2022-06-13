import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/application_bloc.dart';
import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/firestore_bloc.dart';
import 'package:maelstrom/bloc/storage.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/date_time_picker.dart';
import 'package:maelstrom/widgets/create_event/image_picker.dart';
import 'package:maelstrom/widgets/create_event/tag_picker.dart';

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
  TimeOfDay? startTimeController;
  TimeOfDay? endTimeController;
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
    return SingleChildScrollView(
      child: Column(children: [
        BaseAppBar("Créer un évènement"),
        SizedBox(height: 20),
        Center(
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
              DateTimePicker(false, setStartTimeController, startTimeController,
                  "L'heure de début", ThemeColors.principaleBusinessColor),
              SizedBox(height: 20),
              DateTimePicker(false, setEndTimeController, endTimeController,
                  "L'heure de fin", ThemeColors.principaleBusinessColor),
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
        )
      ]),
    );
  }

  submitEvent(pageBloc) async {
    var businessId = FirebaseAuth.instance.currentUser!.uid;

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (imagePathController == '') {
      createError('Veuillez selectionner une image.');
      return;
    } else if (tagsController.length <= 0) {
      createError('Veuillez selectionner au moins un tag.');
      return;
    } else if (dateController == null) {
      createError('Veuillez selectionner une date');
      return;
    } else if (startTimeController == null) {
      createError('Veuillez selectionner une heure de début');
      return;
    } else if (endTimeController == null) {
      createError('Veuillez selectionner une heure de fin');
      return;
    }

    List<Timestamp> allTimestamp =
        dateToTimestemp(dateController, startTimeController, endTimeController);

    if (allTimestamp[0].compareTo(Timestamp.fromDate(DateTime.now())) <
        0) {
      createError('Veuillez selectionner une date dans le future');
      return;
    }

    print(tagsController);

    final currentEvent = EventModel(
        idBusiness: businessId,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        tags: tagsController,
        startDate: allTimestamp[0],
        endDate: allTimestamp[1],
        promote: promoteController,
        imageName: imageNameController);

    _firestoreStorage.uplodFile(imagePathController, imageNameController);

    _firestoreService.createEvent(currentEvent);

    pageBloc.setChangePage(PageType.businessEvent);
  }

  void setDateController(value) => setState(() => dateController = value);
  void setStartTimeController(value) =>
      setState(() => startTimeController = value);
  void setEndTimeController(value) => setState(() => endTimeController = value);
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

  dateToTimestemp(DateTime? date, TimeOfDay? startTime, TimeOfDay? endTime) {
    int? startHour = startTime?.hour;
    int? startMinute = startTime?.minute;
    int? endHour = endTime?.hour;
    int? endMinute = endTime?.minute;

    DateTime? startDateTime = date?.add(Duration(
        hours: startHour != null ? startHour : 0,
        minutes: startMinute != null ? startMinute : 0));
    DateTime? endDateTime = date?.add(Duration(
        hours: endHour != null ? endHour : 0,
        minutes: endMinute != null ? endMinute : 0));

    endDateTime = endDateTime!.isAfter(startDateTime!)
        ? endDateTime
        : endDateTime.add(Duration(days: 1));

    return [Timestamp.fromDate(startDateTime), Timestamp.fromDate(endDateTime)];
  }
}
