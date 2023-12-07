import 'dart:io';

import 'package:Sportzy/pages/detailServico_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

//Classe serviço
class Servico {
  String nome = '';
  String descricao = '';
  double valor = 0.0;
  String rua = '';
  String bairro = '';
  String cidade = '';
}

class FormServicoCreate extends StatefulWidget {
  @override
  _FormServicoCreateState createState() => _FormServicoCreateState();
}

class _FormServicoCreateState extends State<FormServicoCreate> {
  //mapeando campo do formulario  de serviços
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  File imagePath = File('');
  final ImagePicker _imagePicker = ImagePicker();

  //Funão usada para pegar o caminho da imagem
  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      //atualizando a tela com a imagem
      setState(() {
        imagePath = File(pickedFile.path);
      });
    } else {
      print('Nenhuma imagem selecionada.');
    }
  }

  // Widget para construir um campo de texto do formulário
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isRequired,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText:
                '$label${isRequired ? '*' : ''}', // Adiciona * se for obrigatório
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // Função para verificar se todos os campos do formulário estão preenchidos
  bool _areAllFieldsFilled() {
    return _nomeController.text.isNotEmpty &&
        _descricaoController.text.isNotEmpty &&
        _valorController.text.isNotEmpty &&
        _ruaController.text.isNotEmpty &&
        _bairroController.text.isNotEmpty &&
        _cidadeController.text.isNotEmpty;
  }

  //Função que realizar o cadatro de serviço
  void _cadastrarServico() {
    if (_areAllFieldsFilled()) {
      Servico novoServico = (Servico()
        ..nome = _nomeController.text
        ..descricao = _descricaoController.text
        ..valor = double.tryParse(_valorController.text) ?? 0.0
        ..rua = _ruaController.text
        ..cidade = _cidadeController.text
        ..bairro = _bairroController.text);
      //Enviando informações de serviço criado para a tela de detalhesServico
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetalhesServicoPage(
            nomeEvento: novoServico.nome,
            descricaoEvento: novoServico.descricao,
            valorServico: novoServico.valor,
            imagemEvento: imagePath,
            rua: novoServico.rua,
            cidade: novoServico.cidade,
            bairro: novoServico.bairro,
          ),
        ),
      );
    } else {
      // Mostrar uma mensagem ao usuário informando que todos os campos são obrigatórios
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Campos obrigatórios'),
            content: Text(
                'Por favor, preencha todos os campos antes de cadastrar o serviço.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar serviço")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  controller: _nomeController,
                  label: 'Nome',
                  isRequired: true,
                ),
                _buildTextField(
                  controller: _descricaoController,
                  label: 'Descrição',
                  isRequired: true,
                ),
                SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    //Verificanção para evitar valores diferente de numero
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}$')),
                  ],
                  controller: _valorController,
                  decoration: InputDecoration(
                    labelText: 'Preço* ',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _ruaController,
                  label: 'Rua',
                  isRequired: true,
                ),
                _buildTextField(
                  controller: _bairroController,
                  label: 'Bairro',
                  isRequired: true,
                ),
                _buildTextField(
                  controller: _cidadeController,
                  label: 'Cidade',
                  isRequired: true,
                ),
                Row(
                  children: [
                    Text('Foto'),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            _pickImage();
                          },
                          child: Icon(Icons.camera_alt, size: 40),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Image.file(
                      imagePath,
                      width: MediaQuery.of(context).size.width * 0.37,
                      height: MediaQuery.of(context).size.width * 0.37,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _cadastrarServico,
                  child: Text('Cadastrar Serviço'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
