import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/ui/widgets/space_y.dart';
import 'package:provider/provider.dart';
import 'package:group_project/providers/user.provider.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});
  @override
  State<EditProfileView> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfileView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUser;

    _usernameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone ?? '';

    Image userPicture = user.avatarUrl != null
        ? Image.network(user.avatarUrl!)
        : Image.asset("assets/core/woman.png", width: 80, height: 80);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: userPicture,
              ),
              const SpaceY(30),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text('Full name'),
                        prefixIcon: const Icon(
                          Icons.person_3_outlined,
                          color: Color.fromARGB(255, 101, 97, 118)
                        )),
                  ),

                  const SpaceY(15),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text('Email'),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 101, 97, 118)
                        )),
                  ),

                  const SpaceY(15), //

                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        label: const Text('Phone'),
                        prefixIcon: const Icon(Icons.phone, color: Color.fromARGB(255, 101, 97, 118))),
                  ),

                  const SpaceY(15),

                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text("New password"),
                        prefixIcon: const Icon(Icons.password, color: Color.fromARGB(255, 101, 97, 118))),
                  ),

                  const SpaceY(15),

                  TextFormField(
                    obscureText: true,
                    controller: _repasswordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text("Re-enter new password"),
                        prefixIcon: const Icon(Icons.password, color: Color.fromARGB(255, 101, 97, 118))),
                  ),

                  const SpaceY(15),

                  SizedBox(
                    width: double.infinity,
                    child:
                        Consumer<UserProvider>(builder: (context, provider, _) {
                      return ElevatedButton(
                        onPressed: provider.isLoading
                            ? null
                            : () async {
                                final res = await provider.useUpdateProfile(
                                  name: _usernameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                );

                                if (!context.mounted || !mounted) return;

                                if (res.error != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(res.error!)),
                                  );
                                  return;
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(res.data!)),
                                );

                                _passwordController.clear();
                                _repasswordController.clear();
                                context.pop();
                              },
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor:
                        //         const Color.fromARGB(255, 74, 81, 117),
                        //     side: BorderSide.none,
                        //     shape: const StadiumBorder()),
                        child: provider.isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                "Save Profile",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                      );
                    }),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
