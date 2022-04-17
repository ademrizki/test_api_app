import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_api_app/bloc/user_detail_bloc.dart';
import 'package:test_api_app/provider/user_provider.dart';
import 'package:test_api_app/views/screens/user_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        final _provider = Provider.of<UserProvider>(context, listen: false);

        /// Fetch users data
        _provider.fetchUsersData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of User'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) {
          if (provider.users == null) {
            return const Text('Punten, datanya masih null nih');
          } else {
            return ListView.builder(
              itemCount: provider.users!.data!.length,
              itemBuilder: (context, index) {
                final user = provider.users!.data![index];
                return ListTile(
                  leading: Image.network(user.avatar!),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email!),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => UserDetailBloc(),
                        child: UserDetailScreen(
                          id: user.id.toString(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
