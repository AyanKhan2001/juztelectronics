import 'package:juztelectronics/consts/consts.dart';
Widget loadingIndicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(trueGreen),
  );
}