import 'dart:io';

import 'package:Sportzy/pages/detailPartida_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Partida {
  String nome = '';
  String descricao = '';
  String rua = '';
  String bairro = '';
  String cidade = '';
  bool presencial = true; // Valor padrão: presencial
}

class FormPartidaCreate extends StatefulWidget {
  @override
  _FormPartidaCreateState createState() => _FormPartidaCreateState();
}

class _FormPartidaCreateState extends State<FormPartidaCreate> {
  //Mapeando input da tela de formulario Partida
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  bool _presencial = true;
  File imagePath = File('');
  final ImagePicker _imagePicker = ImagePicker();

  //Criando função para busca imagem na galeria
  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Pegando caminho e atualizando tela com a imagem selecionada na galeria
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
        _ruaController.text.isNotEmpty &&
        _bairroController.text.isNotEmpty &&
        _cidadeController.text.isNotEmpty;
  }

  //Função que cria a partida
  void _cadastrarPartida() {
    //verificação para saber se algum campo está vazio
    if (_areAllFieldsFilled()) {
      Partida novaPartida = Partida()
        ..nome = _nomeController.text
        ..descricao = _descricaoController.text
        ..presencial = _presencial
        ..rua = _ruaController.text
        ..cidade = _cidadeController.text
        ..bairro = _bairroController.text;

      ///Enviando informações de Partida criado para a tela de detalhesServico
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetalhesPartidaPage(
                nomeEvento: novaPartida.nome,
                descricaoEvento: novaPartida.descricao,
                presencialEvento: novaPartida.presencial,
                imagemEvento: imagePath,
                rua: novaPartida.rua,
                cidade: novaPartida.cidade,
                bairro: novaPartida.bairro)),
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
      appBar: AppBar(title: Text("Cadastrar partida")),
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
                    Text('Presencial'),
                    Checkbox(
                      value: _presencial,
                      onChanged: (bool? value) {
                        setState(() {
                          _presencial = value ?? false;
                        });
                      },
                    ),
                    Text('Virtual'),
                    Checkbox(
                      value: !_presencial,
                      onChanged: (bool? value) {
                        setState(() {
                          _presencial = !(value ?? true);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
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
                  onPressed: _cadastrarPartida,
                  child: Text('Cadastrar Partida'),
                  style: ElevatedButton.styleFrom(
                    // Cor de fundo
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
