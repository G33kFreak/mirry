import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/config/socket/mirry_socket.dart';
import 'package:mirry_client/src/modules/teeth_brusing_module/bloc/teeth_brushing_module_bloc.dart';

class TeethBrushingModuleBlocProvider extends StatelessWidget {
  final Widget child;

  const TeethBrushingModuleBlocProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TeethBrushingModuleBloc>(
      create: (context) => TeethBrushingModuleBloc(
        mirrySocket: context.read<MirrySocket>(),
      ),
      child: child,
    );
  }
}
