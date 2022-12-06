bool isChecked = false;

String _dropdownValue = "нива";

List<String> dropDownOptions = [
  "нива",
  "Lada",
  "газель",
  "kia",
  "b,w",
  "ваз",
];
MaleFemale? _maleFemale;

num _v = 0;

String fio = "";

String malefemale(MaleFemale? mf){
  if(mf == MaleFemale.isMale){
    return "мужской";
  }
  else{
    return "женский";
  }
}

String robot(bool check){
  if(check){
    return "не робот";
  }
  else{
    return "робот";
  }
}

String text = "";

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});
  static const String _title1 = 'Окно вывода';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title1,
      home: Scaffold(
          appBar: AppBar(title: const Text(_title1)),
          body: Align(alignment: Alignment.topLeft,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Вас зовут: " + fio,),
                    Text("Вы " + robot(isChecked)),
                    Text("Ваш возраст: " + _v.toString()),
                    Text("Ваш пол: " + malefemale(_maleFemale)),
                    Text("Ваш любимый язык программирования: "+_dropdownValue),
                    Text("О вас: " + text)]))
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Регистрация';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

enum MaleFemale { isMale, isFemale }

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {_dropdownValue = selectedValue;});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(20), child: Align(alignment: Alignment.topCenter, child: Text(MyApp._title, textDirection: TextDirection.ltr))),
              Container(padding: EdgeInsets.fromLTRB(42, 0, 42, 0) ,child: TextFormField(decoration: const InputDecoration(hintText: 'Введите ФИО',), onChanged:(String valu){setState(() => {fio=valu});} ,validator: (String? value) {if (value != null) {fio=value;}return null;})),
              Container(padding: EdgeInsets.fromLTRB(20, 20, 0, 0),child: CheckboxListTile(value: isChecked, title: const Text("Я не робот"), controlAffinity: ListTileControlAffinity.leading,onChanged: (bool? value) {setState(() => isChecked = value!);}),),
              Container(padding: EdgeInsets.fromLTRB(10, 20, 0, 0), child: Row(textDirection: TextDirection.ltr, children: <Widget>[
                Expanded(child: Container(padding: EdgeInsets.fromLTRB(60, 0, 0, 0),child: Text('Ваш возраст:',textDirection: TextDirection.ltr,))),
                Expanded(child: Container(padding: EdgeInsets.fromLTRB(0, 0, 20, 0),child:NumberInputWithIncrementDecrement(controller: TextEditingController(), min: 1, max: 100, onDecrement: (val){setState(() {_v = val;});}, onIncrement: (val){setState(() {_v = val;});})))],) ),
              Container(padding: EdgeInsets.fromLTRB(170, 15, 0, 0), child: Row(children: <Widget>[
                Text("Пол:"),
                Radio<MaleFemale>(value: MaleFemale.isMale, groupValue: _maleFemale,onChanged: (val){setState(() {_maleFemale = val;});}),
                Text("М"),
                Radio<MaleFemale>(value: MaleFemale.isFemale, groupValue: _maleFemale,onChanged: (val){setState(() {_maleFemale = val;});}),
                Text("Ж"),
              ],),),
              Container(padding: EdgeInsets.fromLTRB(120, 20, 0, 0), child: Column(children: <Widget>[
                Text("машины любимые:"),
                DropdownButton(items: dropDownOptions.map<DropdownMenuItem<String>>((String mascot) {return DropdownMenuItem<String>(child: Text(mascot), value: mascot);}).toList(),value: _dropdownValue,onChanged: dropdownCallback,),
              ],),),
              TextFormField(onChanged: (String value) {setState(() => {text = value});},minLines: 1, maxLines: 3, keyboardType: TextInputType.multiline, decoration: InputDecoration(hintText: 'Напишите немного о себе', hintStyle: TextStyle(color: Colors.grey), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),),),
              Padding(padding: const EdgeInsets.fromLTRB(160, 20, 0, 0),child: ElevatedButton(onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const MyApp2())),child: const Text('Зарегистрироваться'),))]));
  }
}