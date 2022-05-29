import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/models/tag_model.dart';
import 'package:maelstrom/services/firestoreService.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';

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

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  var tagsController = [];
  final startTimeController = TextEditingController();
  bool promoteController = false;

  // final bool isBusiness;

  // _CreateEventPageState(this.isBusiness);

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    startTimeController.dispose();

    super.dispose();
  }

  List<String> tags = [
    "Célibataire",
    "Autre",
    "Promo",
    "Jeux vidéo",
    "Guest",
    "Quizz",
    "Film",
    "Blind Test",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormInputText(
                nameController,
                'Le nom de votre évènement',
                (value) => value != null && value.length < 4
                    ? "Le nom de votre évènement doit faire au moins 4 characters"
                    : null,
              ),
              SizedBox(height: 20),
              FormInputText(
                descriptionController,
                'La description de votre évènement',
                (value) => value != null && value.length < 5
                    ? 'Le mot de passe doit faire au moins 5 characters'
                    : null,
              ),
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.transparent,
                        blurRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeColors.grayColor,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: MultiSelectDialogField(
                    title: BaseText(TextType.bigText, "Tags"),
                    buttonIcon: Icon(null),
                    selectedItemsTextStyle: GoogleFonts.poppins(
                        fontSize: 12.toDouble(),
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.whiteColor),
                    selectedColor: ThemeColors.principaleBusinessColor,
                    itemsTextStyle: TextStyle(
                      color: ThemeColors.textUnfocusColor,
                      fontSize: 12.toDouble(),
                      fontWeight: FontWeight.w400,
                    ),
                    unselectedColor: ThemeColors.grayColor,
                    confirmText: Text("Valider",
                        style: GoogleFonts.poppins(
                            fontSize: 14.toDouble(),
                            fontWeight: FontWeight.w400,
                            color: ThemeColors.principaleBusinessColor)),
                    cancelText: Text("Annuler",
                        style: GoogleFonts.poppins(
                            fontSize: 14.toDouble(),
                            fontWeight: FontWeight.w400,
                            color: ThemeColors.textUnfocusColor)),
                    buttonText: Text("Tags",
                        style: GoogleFonts.poppins(
                            fontSize: 14.toDouble(),
                            fontWeight: FontWeight.w400,
                            color: ThemeColors.whiteColor)),
                    backgroundColor: ThemeColors.backgroundColor,
                    items: tags.map((e) => MultiSelectItem(e, e)).toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      tagsController = values;
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      items: tagsController
                          .map((e) => MultiSelectItem(e, e))
                          .toList(),
                      chipColor: ThemeColors.principaleBusinessColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      textStyle: GoogleFonts.poppins(
                          fontSize: 12.toDouble(),
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.whiteColor),
                      // alignment: Alignment.center,
                      onTap: (value) {
                        setState(() {
                          tagsController.remove(value);
                        });
                      },
                    ),
                  )),
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
              BaseButton(ButtonsType.big, submitEvent, "Créer l'évènement", [
                ThemeColors.principaleBusinessColor,
                ThemeColors.radientBusinessColor
              ]),
              SizedBox(height: 20),
            ],
          ),
        ));
  }

  Future submitEvent() async {
    print('Création');
    var businessId = FirebaseAuth.instance.currentUser!.uid;

    // final currentEvent = Event(
    //     idBusiness: businessId,
    //     nameController.text.trim(),
    //     description: descriptionController.text.trim(),
    //     tags: tags,
    //     date: date,
    //     promote: promote);

    // _firestoreService.createEvent(currentEvent);
  }
}
