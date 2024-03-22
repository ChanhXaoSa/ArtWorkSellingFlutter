import 'package:aws_flutter/login_screen.dart';
import 'package:aws_flutter/widgets/inputTextWidget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double r = (175 / 360); //  rapport for web test(304 / 540);
    final coverHeight = screenWidth * r;
    bool pinned = false;
    bool snap = false;
    bool floating = false;

    final widgetList = [
      const Row(
        children: [
          SizedBox(
            width: 28,
          ),
          Text(
            'Art Work Sharing',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      const SizedBox(
        height: 12.0,
      ),
      Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'Sign Up now!!',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 25.0,
            ),
            const InputTextWidget(
                labelText: "First Name",
                icon: Icons.person,
                obscureText: false,
                keyboardType: TextInputType.text),
            const SizedBox(
              height: 12.0,
            ),
            const InputTextWidget(
                labelText: "Last Name",
                icon: Icons.person,
                obscureText: false,
                keyboardType: TextInputType.text),
            const SizedBox(
              height: 12.0,
            ),
            InputTextWidget(
                controller: _emailController,
                labelText: "Email Address",
                icon: Icons.email,
                obscureText: false,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(
              height: 12.0,
            ),
            const InputTextWidget(
                labelText: "Phone Number",
                icon: Icons.phone,
                obscureText: false,
                keyboardType: TextInputType.number),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Material(
                elevation: 15.0,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(15.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 15.0),
                  child: TextFormField(
                      obscureText: true,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 32.0, /*Color(0xff224597)*/
                        ),
                        labelText: "Password",
                        labelStyle:
                            TextStyle(color: Colors.black54, fontSize: 18.0),
                        hintText: '',
                        enabledBorder: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        border: InputBorder.none,
                      ),
                      controller: _pass,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Type a password ';
                        } else if (val.length < 6) {
                          return 'Password must be > 6 characters';
                        }

                        return null;
                      }),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Material(
                elevation: 15.0,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(15.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 15.0),
                  child: TextFormField(
                      obscureText: true,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 32.0, /*Color(0xff224597)*/
                        ),
                        labelText: "Confirm Password",
                        labelStyle:
                            TextStyle(color: Colors.black54, fontSize: 18.0),
                        hintText: '',
                        enabledBorder: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        border: InputBorder.none,
                      ),
                      controller: _confirmPass,
                      validator: (val) {
                        if (val!.isEmpty) return 'Confirm password!!';
                        if (val != _pass.text) {
                          return 'Incorrect password';
                        }
                        return null;
                      }),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            SizedBox(
              height: 55.0,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {}
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  minimumSize: Size(screenWidth, 150),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Color(0xffC79D67),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                      color: const Color(0xffC79D67),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 15.0,
      )
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: pinned,
            snap: snap,
            floating: floating,
            expandedHeight: coverHeight - 25,
            backgroundColor: const Color(0xFFdccdb4),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background:
                  Image.asset("assets/images/cover.jpg", fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(),
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xFF7A8BA3), Color(0xFF7A8BA3)])),
              width: screenWidth,
              height: 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: screenWidth,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return widgetList[index];
            }, childCount: widgetList.length),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 50.0,
            color: Colors.white,
            child: Center(
                child: Wrap(
              children: [
                Text(
                  "Already have an account?  ",
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold),
                ),
                Material(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
