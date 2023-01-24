import 'package:flutter/material.dart';

class IMCPage extends StatefulWidget {
  const IMCPage({super.key});

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  final TextEditingController heightTextEditingController =
      TextEditingController();

  final TextEditingController weightTextEditingController =
      TextEditingController();

  double imcResult = 0.0;

  bool errorHeight = false;
  bool errorWeight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {
              setState(() {
                heightTextEditingController.clear();
                weightTextEditingController.clear();
                errorHeight = false;
                errorWeight = false;
                imcResult = 0;
              }),
            },
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.person_outline,
                size: 128,
                color: Colors.blue,
              ),

              //Height
              TextField(
                controller: heightTextEditingController,
                decoration: InputDecoration(
                  label: const Text('Altura'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  suffix: const Text('m'),
                  hintText: 'Ex: 1,68',
                  errorText:
                      errorHeight ? 'Este campo não pode ficar vazio!' : null,
                ),
                keyboardType: TextInputType.number,
              ),

              //Space Vertical
              const SizedBox(
                height: 15,
              ),

              //Weight
              TextField(
                controller: weightTextEditingController,
                decoration: InputDecoration(
                  label: const Text('Peso'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  suffix: const Text('Kg'),
                  hintText: 'Ex: 75,3',
                  errorText:
                      errorWeight ? 'Este campo não pode ficar vazio!' : null,
                ),
                keyboardType: TextInputType.number,
              ),

              //Space Vertical
              const SizedBox(
                height: 15,
              ),

              //Button calculation
              ElevatedButton(
                onPressed: () => calculateIMC(),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(
                    200,
                    50,
                  ),
                ),
                child: const Text('Calcular'),
              ),

              //Space Vertical
              const SizedBox(
                height: 15,
              ),

              //Results
              imcResult != 0
                  ? Text(
                      'Seu IMC é: ${imcResult.toStringAsFixed(1)}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  : const Text(
                      'Preencha seus dados',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateIMC() {
    String heightText = heightTextEditingController.text;
    String weightText = weightTextEditingController.text;

    setState(() {
      if (heightText != '' && weightText != '') {
        double heightValue = double.parse(
          heightText.replaceAll(',', '.'),
        );
        double weightValue = double.parse(
          weightText.replaceAll(',', '.'),
        );
        errorHeight = false;
        errorWeight = false;
        imcResult = weightValue / (heightValue * heightValue);
      } else {
        if (heightText == '' && weightText == '') {
          errorHeight = true;
          errorWeight = true;
        } else if (heightText == '') {
          errorHeight = true;
          errorWeight = false;
        } else if (weightText == '') {
          errorHeight = false;
          errorWeight = true;
        }
      }
    });
  }
}
