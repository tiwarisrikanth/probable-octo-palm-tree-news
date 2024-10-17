import 'package:country_picker/country_picker.dart';
import 'package:firstpro/auth/signin.dart';
import 'package:firstpro/TaxiApp/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String code = "";
  String codeF = "";
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      FocusScope.of(context).requestFocus(FocusNode());
    });

    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Hide the OS keyboard
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    });
  }

  void _onTextInput(String text) {
    final textSelection = _controller.selection;
    final newText = _controller.text.replaceRange(
      textSelection.start,
      textSelection.end,
      text,
    );
    _controller.value = _controller.value.copyWith(
      text: newText,
      selection:
          TextSelection.collapsed(offset: textSelection.start + text.length),
    );
  }

  void _onBackspace() {
    final textSelection = _controller.selection;
    final newText = _controller.text.replaceRange(
      textSelection.start - 1,
      textSelection.start,
      '',
    );
    _controller.value = _controller.value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: textSelection.start - 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Enter your mobile number',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Hero(
                    tag: 'number',
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode:
                                  true, // optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  code = country.phoneCode;
                                  codeF = country.flagEmoji;
                                });
                                // print(
                                //     'Select country: ${country.displayNameNoCountryCode}  ${country.flagEmoji} ${country.countryCode}   ${country.name}');
                              },
                            );
                          },
                          child: Container(
                            // width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFFF6969).withOpacity(0.3),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                  child: Center(child: Text(codeF)),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  code == "" ? " - " : " +$code ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 25,
                                  color: Colors.red.withOpacity(0.4),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFA1DD70).withOpacity(0.3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                maxLength: 10,
                                autofocus: true,
                                controller: _controller,
                                focusNode: _focusNode,
                                decoration: InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintText: "3456789765",
                                ),
                                onTap: () {
                                  // Ensure focus is set
                                  _focusNode.requestFocus();
                                  // Hide the OS keyboard
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "By continuing yiou may recieve an SMS for verificatoion. Messages and data rates May apply.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                )),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    if (code == "") {
                      toastification.show(
                        context:
                            context, // optional if you use ToastificationWrapper
                        type: ToastificationType.error,
                        style: ToastificationStyle.flatColored,
                        autoCloseDuration: const Duration(seconds: 5),
                        title: Text(
                          'Error Occured!',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // you can also use RichText widget for title and description parameters
                        description: RichText(
                          text: const TextSpan(
                            text: 'Please select country code',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),

                        alignment: Alignment.topRight,
                        direction: TextDirection.ltr,
                        animationDuration: const Duration(milliseconds: 300),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x07000000),
                            blurRadius: 16,
                            offset: Offset(0, 16),
                            spreadRadius: 0,
                          )
                        ],
                        progressBarTheme: ProgressIndicatorThemeData(
                            linearTrackColor: Colors.red.withOpacity(0.2),
                            color: Colors.red),
                        showProgressBar: true,
                        closeButtonShowType: CloseButtonShowType.onHover,
                        closeOnClick: false,
                        pauseOnHover: true,
                        dragToClose: true,
                      );
                    } else if (_controller.text == "") {
                      toastification.show(
                        context:
                            context, // optional if you use ToastificationWrapper
                        type: ToastificationType.error,
                        style: ToastificationStyle.flatColored,
                        autoCloseDuration: const Duration(seconds: 5),
                        title: Text(
                          'Error Occured!',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // you can also use RichText widget for title and description parameters
                        description: RichText(
                          text: const TextSpan(
                            text: 'Please enter mobile number',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),

                        alignment: Alignment.topRight,
                        direction: TextDirection.ltr,
                        animationDuration: const Duration(milliseconds: 300),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x07000000),
                            blurRadius: 16,
                            offset: Offset(0, 16),
                            spreadRadius: 0,
                          )
                        ],
                        progressBarTheme: ProgressIndicatorThemeData(
                            linearTrackColor: Colors.red.withOpacity(0.2),
                            color: Colors.red),
                        showProgressBar: true,
                        closeButtonShowType: CloseButtonShowType.onHover,
                        closeOnClick: false,
                        pauseOnHover: true,
                        dragToClose: true,
                      );
                    } else if (codeF == "") {
                      toastification.show(
                        context:
                            context, // optional if you use ToastificationWrapper
                        type: ToastificationType.error,
                        style: ToastificationStyle.flatColored,
                        autoCloseDuration: const Duration(seconds: 5),
                        title: Text(
                          'Error Occured!',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // you can also use RichText widget for title and description parameters
                        description: RichText(
                          text: const TextSpan(
                            text: 'Please select country code',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),

                        alignment: Alignment.topRight,
                        direction: TextDirection.ltr,
                        animationDuration: const Duration(milliseconds: 300),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x07000000),
                            blurRadius: 16,
                            offset: Offset(0, 16),
                            spreadRadius: 0,
                          )
                        ],
                        progressBarTheme: ProgressIndicatorThemeData(
                            linearTrackColor: Colors.red.withOpacity(0.2),
                            color: Colors.red),
                        showProgressBar: true,
                        closeButtonShowType: CloseButtonShowType.onHover,
                        closeOnClick: false,
                        pauseOnHover: true,
                        dragToClose: true,
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(context,
                          FadePageRoute(page: HomePage()), (route) => false);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: Colors.green),
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomKeyboard(
              onTextInput: _onTextInput,
              onBackspace: _onBackspace,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomKeyboard extends StatelessWidget {
  final Function(String) onTextInput;
  final Function() onBackspace;

  CustomKeyboard({required this.onTextInput, required this.onBackspace});

  void _textInputHandler(String text) => onTextInput(text);
  void _backspaceHandler() => onBackspace();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      // decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      // color: Colors.white,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 16 / 9),
        itemCount: 12,
        itemBuilder: (context, index) {
          if (index == 9) {
            return buildBackspaceKey();
          } else if (index == 10) {
            return buildTextKey("0");
          } else if (index == 11) {
            return buildSubmitKey();
          } else {
            return buildTextKey((index + 1).toString());
          }
        },
      ),
    );
  }

  Widget buildTextKey(String text) {
    return InkWell(
      onTap: () => _textInputHandler(text),
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey)
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey,
            //     offset: Offset(0, 1),
            //     blurRadius: 1,
            //   ),
            // ],
            ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildBackspaceKey() {
    return InkWell(
      onTap: _backspaceHandler,
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     offset: Offset(0, 1),
          //     blurRadius: 1,
          //   ),
          // ],
        ),
        child: Center(
          child: Icon(Icons.backspace, size: 24),
        ),
      ),
    );
  }

  Widget buildSubmitKey() {
    return InkWell(
      onTap: () {
        // Handle submit action
      },
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Icon(Icons.check, size: 24),
        ),
      ),
    );
  }
}
