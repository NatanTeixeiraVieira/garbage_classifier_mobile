import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/text_field_app.dart';

class AddressFormSection extends StatelessWidget {
  final TextEditingController cepController;
  final TextEditingController streetController;
  final TextEditingController neighborhoodController;
  final TextEditingController cityController;
  final void Function(String) onCepChanged;

  const AddressFormSection({
    super.key,
    required this.cepController,
    required this.streetController,
    required this.neighborhoodController,
    required this.cityController,
    required this.onCepChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldApp(
          label: "CEP",
          controller: cepController,
          hint: "Digite seu CEP (apenas números)",
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value?.length != 8) return "CEP inválido";
            return null;
          },
          onChanged: onCepChanged,
        ),
        const SizedBox(height: 16),
        TextFieldApp(
          label: "Rua",
          controller: streetController,
          hint: "Nome da rua",
          validator: (value) {
            if ((value?.length ?? 0) < 3) {
              return "A rua deve ter ao menos 3 caracteres";
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFieldApp(
          label: "Bairro",
          controller: neighborhoodController,
          hint: "Nome do bairro",
          validator: (value) {
            if ((value?.length ?? 0) < 3) {
              return "O bairro deve ter ao menos 3 caracteres";
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFieldApp(
          label: "Cidade",
          controller: cityController,
          hint: "Nome da cidade",
          validator: (value) {
            if ((value?.length ?? 0) < 3) {
              return "A cidade deve ter ao menos 3 caracteres";
            }
            return null;
          },
        ),
      ],
    );
  }
}
