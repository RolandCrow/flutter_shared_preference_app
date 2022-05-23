import 'package:flutter/material.dart';
import 'package:flutter_shared_preference_app/utils/user_simple_preferences.dart';
import 'package:flutter_shared_preference_app/widget/birthday_widget.dart';
import 'package:flutter_shared_preference_app/widget/button_widget.dart';
import 'package:flutter_shared_preference_app/widget/pets_button_widget.dart';
import 'package:flutter_shared_preference_app/widget/title_widget.dart';

class UserPage extends StatefulWidget {

  final String? idUser;

  const UserPage({
    Key? key,
  this.idUser,
}): super(key: key);

  @override
  State<StatefulWidget> createState() => _UserPageState();



}


class _UserPageState extends State<UserPage> {

  final formKey = GlobalKey<FormState>();
  String name = '';
  late DateTime birthday;
  List<String> pets = [];


      @override
  void initState() {
    super.initState();

    name = UserSimplePreferences.getUsername()!;
    pets = UserSimplePreferences.getPets()!;
    birthday = UserSimplePreferences.getBirthday()!;

  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children:  [
                const  TitleWidget(icon: Icons.save_alt, text: 'Shared\nPreferences'),
               const SizedBox(height: 32,),
                buildName(),
                const SizedBox(height: 12,),
                buildBirthday(),
                const SizedBox(height: 12,),
                buildPets(),
                const SizedBox(height: 32,),
                buildButton(),

              ],
            ),
          ),
        );
  }

  Widget buildName() => buildTitle(
      title: 'Name',
      child: TextFormField(
        initialValue: name,
        decoration:  InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Your Name',
        ),
        onChanged: (name) => setState(() => this.name = name),
      ));


      Widget buildBirthday() {
        return buildTitle(
            title: 'Birthday',
            child: BirthdayWidget(
                birthday: birthday,
                onChangedBirthday: (birthday) => setState(() => this.birthday = birthday)));
      }

      Widget buildPets() {
        return buildTitle(
            title: 'Pets',
            child: PetsButtonWidget(
                pets: pets,
                onSelectedPet: (pet) => setState(() =>
                pets.contains(pet) ? pets.remove(pet): pets.add(pet))));
      }

      Widget buildButton() {
        return ButtonWidget(
            text: 'Save',
            onClicked: () async{
                await UserSimplePreferences.setUsername(name);
                await UserSimplePreferences.setPets(pets);
                await UserSimplePreferences.setBirthday(birthday);

            });
      }



  Widget buildTitle({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8,),
          child,
        ],
      );















}