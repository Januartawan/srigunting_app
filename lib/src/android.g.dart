// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'android.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Android extends Android {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<LocalStorageRepository>((c) => SecureStorage(),
          name: 'secure_storage')
      ..registerSingleton<Dio>(
          (c) => DioModule(c.resolve<LocalStorageRepository>('secure_storage')),
          name: 'dio')
      ..registerSingleton<AuthRepository>(
          (c) => AuthRestRepository(c.resolve<Dio>('dio')),
          name: 'auth_repository')
      ..registerSingleton<GuideRepository>(
          (c) => GuideRestRepository(c.resolve<Dio>('dio')),
          name: 'guide_repository')
      ..registerSingleton<BalanceRepopsitory>(
          (c) => BalanceRestRepository(c.resolve<Dio>('dio')),
          name: 'balance_repository')
      ..registerSingleton<RewardRepository>(
          (c) => RewardRestRepository(c.resolve<Dio>('dio')),
          name: 'reward_repository')
      ..registerSingleton<InformationRepository>(
          (c) => InformationRestRepository(c.resolve<Dio>('dio')),
          name: 'information_repository')
      ..registerSingleton<NotificationRepository>(
          (c) => NotificationRestRepository(c.resolve<Dio>('dio')),
          name: 'notification_repository')
      ..registerSingleton<FeedbackRepository>(
          (c) => FeedbackRestRepository(c.resolve<Dio>('dio')),
          name: 'feedback_repository')
      ..registerSingleton<FreeVisitDetailRepository>(
          (c) => FreeVisitDetailRestRepository(c.resolve<Dio>('dio')),
          name: 'free_visit_detail_repository')
      ..registerSingleton<AtributeRepository>(
          (c) => AtributeRestRepository(c.resolve<Dio>('dio')),
          name: 'atribute_repository')
      ..registerFactory((c) => FreeTicketDetailBloc(
          c.resolve<LocalStorageRepository>('secure_storage')))
      ..registerFactory((c) =>
          FreeTicketUseBloc(c.resolve<RewardRepository>('reward_repository')))
      ..registerFactory((c) => InitialLoadingBloc(
          c.resolve<LocalStorageRepository>('secure_storage')))
      ..registerFactory((c) => NotificationBloc(
          c.resolve<NotificationRepository>('notification_repository')))
      ..registerFactory((c) => InformationDetailBloc(
          c.resolve<InformationRepository>('information_repository')))
      ..registerFactory((c) => SkemaSusukBloc(
          c.resolve<InformationRepository>('information_repository')))
      ..registerFactory((c) => FlowClaimSusukBloc(
          c.resolve<InformationRepository>('information_repository')))
      ..registerFactory((c) => PricelistProgramBloc(
          c.resolve<InformationRepository>('information_repository')))
      ..registerFactory((c) => PricelistProgramDetailBloc(
          c.resolve<InformationRepository>('information_repository')))
      ..registerFactory((c) =>
          FeedbackBloc(c.resolve<FeedbackRepository>('feedback_repository')))
      ..registerFactory((c) =>
          RedeemPointBloc(c.resolve<RewardRepository>('reward_repository')))
      ..registerFactory((c) =>
          FreeTicketBloc(c.resolve<RewardRepository>('reward_repository')))
      ..registerFactory((c) => InformationBloc(
          c.resolve<InformationRepository>('information_repository')))
      ..registerFactory((c) => CommisionHistoryBloc(
          c.resolve<BalanceRepopsitory>('balance_repository'),
          c.resolve<GuideRepository>('guide_repository'),
          c.resolve<RewardRepository>('reward_repository')))
      ..registerFactory((c) => CommisionHistoryDetailBloc(
          c.resolve<BalanceRepopsitory>('balance_repository')))
      ..registerFactory((c) => ProfileUpdatePasswordBloc(
          c.resolve<AuthRepository>('auth_repository')))
      ..registerFactory((c) => ProfileUpdateBloc(
          c.resolve<GuideRepository>('guide_repository'),
          c.resolve<AtributeRepository>('atribute_repository')))
      ..registerFactory((c) =>
          ProfileShowBloc(c.resolve<GuideRepository>('guide_repository')))
      ..registerFactory((c) => ProfileBloc(
          c.resolve<GuideRepository>('guide_repository'),
          c.resolve<RewardRepository>('reward_repository'),
          c.resolve<AuthRepository>('auth_repository'),
          c.resolve<LocalStorageRepository>('secure_storage')))
      ..registerFactory((c) => LoginBloc(
          c.resolve<AuthRepository>('auth_repository'),
          c.resolve<LocalStorageRepository>('secure_storage')))
      ..registerFactory((c) => HomeBloc(
          c.resolve<GuideRepository>('guide_repository'),
          c.resolve<BalanceRepopsitory>('balance_repository'),
          c.resolve<RewardRepository>('reward_repository'),
          c.resolve<InformationRepository>('information_repository'),
          c.resolve<LocalStorageRepository>('secure_storage'),
          c.resolve<NotificationRepository>('notification_repository'),
          c.resolve<AuthRepository>('auth_repository')))
      ..registerFactory(
          (c) => RegisterBloc(c.resolve<AuthRepository>('auth_repository')))
      ..registerFactory((c) => FreeVisitDetailBloc(
          c.resolve<FreeVisitDetailRepository>('free_visit_detail_repository')))
      ..registerFactory((c) =>
          ProfileUpdateEmailBloc(c.resolve<AuthRepository>('auth_repository')))
      ..registerFactory((c) => ProfileUpdateUsernameBloc(
          c.resolve<AuthRepository>('auth_repository')));
  }
}
