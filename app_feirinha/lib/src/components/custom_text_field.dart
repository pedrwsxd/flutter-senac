import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  // passando dados para ícone e label
  final IconData icon;
  final String label;

  // variável para configurar a ocultação da senha
  final bool isSecret;

  const CustomTextField(
      {super.key,
      required this.icon,
      required this.label,
      this.isSecret = false, required TextEditingController controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // variável para configurar a ocultação da senha
  bool isObscure = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        // definindo a ocultação da senha
        obscureText: isObscure,
        decoration: InputDecoration(

          // passando dados do icone e label
            prefixIcon: Icon(widget.icon),
            labelText: widget.label,

            // --- icone de exibição da senha
            suffixIcon: widget.isSecret
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon( isObscure ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
            isDense: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
