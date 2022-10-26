import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_app/bloc/user_detail_bloc.dart';
import 'package:test_api_app/bloc/user_detail_event.dart';
import 'package:test_api_app/bloc/user_detail_state.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserDetailBloc>().add(GetUserDetail(widget.id));
    context.read<UserDetailBloc>().stream.listen((state) {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant UserDetailScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: BlocBuilder<UserDetailBloc, UserDetailState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is ErrorState) {
            return Text(state.errorMessage);
          } else if (state is SuccessState) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Image
                  Image.network(state.userDetail.data!.avatar!),

                  /// Nama
                  Text(
                      '${state.userDetail.data!.firstName} ${state.userDetail.data!.lastName}')
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    context.read<UserDetailBloc>().close();
    super.dispose();
  }
}
