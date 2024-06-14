import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});
  @override
  State<PaymentView> createState() => _Payment();
}

class _Payment extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                child: Image.asset(
                  "assets/core/credit-card.png",
                  width: double.infinity,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () => context.go('/profile/payment/methods'),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 222, 111, 209)
                          .withOpacity(0.2)),
                  child: const Icon(
                    Icons.money,
                  ),
                ),
                title: Text(
                  "Payment Methods",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 222, 111, 209)
                          .withOpacity(0.2)),
                  child: const Icon(
                    Icons.arrow_right_alt_rounded,
                    color: Color.fromARGB(255, 188, 165, 231),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
