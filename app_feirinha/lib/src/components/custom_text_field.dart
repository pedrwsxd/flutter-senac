import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // passando dados para ícone e label
  final IconData icon;
  final String label;

  // variável para configurar a ocultação da senha
  final bool isObscure;

  const CustomTextField(
      {super.key,
      required this.icon,
      required this.label,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        // definindo a ocultação da senha
        obscureText: isObscure,
        decoration: InputDecoration(

          // passando dados do icone e label
            prefixIcon: Icon(icon),
            labelText: label,

            // --- icone de exibição da senha
            suffixIcon: isObscure
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility),
                  )
                : null,
            isDense: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
