import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget { //classe que representa o aplicativo
  @override
  Widget build(BuildContext context){ //constroi a interface.
    return MaterialApp( //tipo do layout
     home: Home(), //builda nossa home, chamando a classe Home
     debugShowCheckedModeBanner: false, //remove a barra debug.




    );
  }
}


class Home extends StatefulWidget{
 _HomeState createState() => _HomeState(); //cria um estado para tela inicial
}


class _HomeState extends State<Home>{ //classe que representa o Estado da Home
 final TextEditingController _gasolinaController = TextEditingController();
 final TextEditingController _alcoolController = TextEditingController();


 String _resultado = "Informe seus dados!";
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //validação do formulario.


 void _limparCampos(){
  _gasolinaController.text = "";
  _alcoolController.text = "";
 
  setState(() {
    _resultado = "Informe o valor do Álcool e Gasolina!";
  });
 }


 void _calcular(){
  double gasolina = double.parse(_gasolinaController.text);
  double alcool = double.parse(_alcoolController.text);


  double calculoCombustivel = alcool / gasolina;
  setState(() {
   if (calculoCombustivel < 0.7){
    _resultado = "Abasteça com Álcool (${calculoCombustivel.toStringAsPrecision(3)})";
   }  else {
    _resultado = "Abasteça com Gasolina (${calculoCombustivel.toStringAsPrecision(3)})";
   }
  });
 }
 @override
 Widget build(BuildContext context){


  return Scaffold(
    appBar: AppBar( //barra de titulo da tela
      title: Text("Calculadora de Combustivel"),
      centerTitle: true,
      backgroundColor: Colors.orange,
      actions: <Widget>[
        IconButton(onPressed: _limparCampos, icon: Icon(Icons.refresh))
      ],

    ),
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.show_chart_outlined, size: 120.0, color: Colors.orange),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Gasolina (Reais)",
                labelStyle: TextStyle(color: Colors.orange),
              ),
              textAlign: TextAlign.center, //alinha o texto ao centro.
              style: TextStyle(color: Colors.orange, fontSize:25.0),
              //controller
              controller: _gasolinaController,
              //validador
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Insira o valor da gasolina.";
                }
              },
            ),
          //alcool
            TextFormField(
              //sobe o teclado para configurar
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Álcool (Reais)",
                labelStyle: TextStyle(color: Colors.orange)
              ),
              textAlign: TextAlign.center, //alinha o texto ao centro.
              style: TextStyle(color: Colors.orange, fontSize:25.0),
              //controller
              controller: _alcoolController,
              //validador
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Insira o valor do Álcool";
                }
              },
            ),
            Padding(
                padding: EdgeInsets.only(top:10.0, bottom:10.0),
              ),
            //botões
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: _calcular,child: Text("Calcular Combustivel",style: TextStyle(color:Colors.white, fontSize: 25.0),),style: ElevatedButton.styleFrom(backgroundColor:Colors.orange),),),
                Expanded(child: ElevatedButton(onPressed: _limparCampos,child: Text("Limpar Campos",style: TextStyle(color:Colors.white, fontSize: 25.0),),style: ElevatedButton.styleFrom(backgroundColor:Colors.orange),),),              ],
            ),
            
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange, fontSize: 25.00)
            )
          ],
        ),
      ),
    ),
  );
 }


}
