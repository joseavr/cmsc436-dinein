import 'package:flutter/material.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:provider/provider.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});
  @override
  State<ContactUsView> createState() => _ContactUs();
}

class _ContactUs extends State<ContactUsView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _msgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Contact Us",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            children: [
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text("Your Name"),
                        prefixIcon: const Icon(Icons.person_3_outlined,
                            color: Color.fromARGB(255, 101, 97, 118))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text("Email"),
                        prefixIcon: const Icon(Icons.email,
                            color: Color.fromARGB(255, 101, 97, 118))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _msgController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        labelText: "Your Message...",
                        prefixIcon: const Icon(Icons.messenger_outline_outlined,
                            color: Color.fromARGB(255, 101, 97, 118))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<UserProvider>(
                      builder: (context, provider, _) {
                        return ElevatedButton(
                          onPressed: provider.isLoading
                              ? null
                              : () async {
                                  try {
                                    final res =
                                        await provider.useSendContactForm(
                                            senderName: _nameController.text,
                                            senderEmail: _emailController.text,
                                            senderMessage: _msgController.text);

                                    if (!context.mounted || !mounted) return;

                                    if (res.error != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(res.error!)),
                                      );
                                      return;
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(res.data!)));
                                  } on Exception catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.toString())));
                                  }
                                },
                          // style: ElevatedButton.styleFrom(
                          //     backgroundColor:
                          //         const Color.fromARGB(255, 74, 81, 117),
                          //     side: BorderSide.none,
                          //     shape: const StadiumBorder()),
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : Text("Submit",
                                  style: Theme.of(context).textTheme.bodyLarge),
                        );
                      },
                    ),
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
