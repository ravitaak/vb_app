import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vb_app/bloc/auth/auth_bloc.dart';
import 'package:vb_app/bloc/private/private_cubit.dart';
import 'package:vb_app/bloc/subscription/subscription_cubit.dart';
import 'package:vb_app/bloc/theme/theme_cubit.dart';
import 'package:vb_app/bloc/user/user_cubit.dart';
import 'package:vb_app/bloc/vb/vidya_box_cubit.dart';

List<BlocProvider> providers = [
  BlocProvider<ThemeCubit>(
    create: (context) => ThemeCubit(),
  ),
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(),
  ),
  BlocProvider<UserCubit>(
    create: (context) => UserCubit(),
  ),
  BlocProvider<PrivateCubit>(
    create: (context) => PrivateCubit(context.read<UserCubit>()),
  ),
  BlocProvider<SubscriptionCubit>(
    create: (context) => SubscriptionCubit(context.read<UserCubit>()),
  ),
  BlocProvider<VidyaBoxCubit>(
    create: (context) => VidyaBoxCubit(),
  ),
];
