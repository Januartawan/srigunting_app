import 'package:kiwi/kiwi.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/secure_storage/secure_storage.dart';
import 'package:srigunting_app/src/repository/auth_repository.dart';
import 'package:srigunting_app/src/repository/balance_repopsitory.dart';
import 'package:srigunting_app/src/repository/free_visit_detail_repository.dart';
import 'package:srigunting_app/src/repository/guide_repository.dart';
import 'package:srigunting_app/src/repository/information_repository.dart';
import 'package:srigunting_app/src/repository/notification_repository.dart';
import 'package:srigunting_app/src/repository/rest/auth_rest_repository.dart';
import 'package:dio/dio.dart';
import 'package:srigunting_app/src/repository/rest/balance_rest_repository.dart';
import 'package:srigunting_app/src/repository/rest/free_visit_detail_rest_repository.dart';
import 'package:srigunting_app/src/repository/rest/guide_rest_repository.dart';
import 'package:srigunting_app/src/repository/rest/information_rest_repository.dart';
import 'package:srigunting_app/src/repository/feedback_repository.dart';
import 'package:srigunting_app/src/repository/rest/feedback_rest_repository.dart';
import 'package:srigunting_app/src/repository/rest/notification_rest_repository.dart';
import 'package:srigunting_app/src/repository/rest/reward_rest_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/dio_module.dart';
import 'package:srigunting_app/src/repository/reward_repository.dart';
import 'package:srigunting_app/src/ui/app/commision_history/bloc/commision_history_bloc.dart';
import 'package:srigunting_app/src/ui/app/commmision_history_detail/bloc/commision_history_detail_bloc.dart';
import 'package:srigunting_app/src/ui/app/free_ticket/bloc/free_ticket_bloc.dart';
import 'package:srigunting_app/src/ui/app/free_ticket_detail/bloc/free_ticket_detail_bloc.dart';
import 'package:srigunting_app/src/ui/app/free_ticket_use/bloc/free_ticket_use_bloc.dart';
import 'package:srigunting_app/src/ui/app/free_visit_detail/bloc/free_visit_detail_bloc.dart';
import 'package:srigunting_app/src/ui/app/home/bloc/home_bloc.dart';
import 'package:srigunting_app/src/ui/app/information/bloc/information_bloc.dart';
import 'package:srigunting_app/src/ui/app/information_detail/bloc/information_detail_bloc.dart';
import 'package:srigunting_app/src/ui/app/notification/bloc/notification_bloc.dart';
import 'package:srigunting_app/src/ui/app/profile/bloc/profile_bloc.dart';
import 'package:srigunting_app/src/ui/app/profile_show/bloc/profile_show_bloc.dart';
import 'package:srigunting_app/src/ui/app/profile_update/bloc/profile_update_bloc.dart';
import 'package:srigunting_app/src/ui/app/profile_update_password/bloc/profile_update_password_bloc.dart';
import 'package:srigunting_app/src/ui/app/redeem_point/bloc/redeem_point_bloc.dart';
import 'package:srigunting_app/src/ui/initial_loading/bloc/initial_loading_bloc.dart';
import 'package:srigunting_app/src/ui/login/bloc/login_bloc.dart';
import 'package:srigunting_app/src/ui/register/bloc/register_bloc.dart';
import 'package:srigunting_app/src/repository/atribute_repository.dart';
import 'package:srigunting_app/src/repository/rest/atribute_rest_repository.dart';
import 'package:srigunting_app/src/ui/app/profile_update_email/bloc/profile_update_email_bloc.dart';
import 'package:srigunting_app/src/ui/app/profile_update_username/bloc/profile_update_username_bloc.dart';
import 'package:srigunting_app/src/ui/app/skema_susuk/bloc/skema_susuk_bloc.dart';
import 'package:srigunting_app/src/ui/app/flow_claim_susuk/bloc/flow_claim_susuk_bloc.dart';
import 'package:srigunting_app/src/ui/app/pricelist_program/bloc/pricelist_program_bloc.dart';
import 'package:srigunting_app/src/ui/app/pricelist_program_detail/bloc/pricelist_program_detail_bloc.dart';
import 'package:srigunting_app/src/ui/app/feedback/bloc/feedback_bloc.dart';

part 'ios.g.dart';

//run cmd: dart run build_runner watch

abstract class Ios {
  //TODO add ios dependency injection here

  //INFRA LAYER
  @Register.singleton(LocalStorageRepository,
      name: "secure_storage", from: SecureStorage)
  @Register.singleton(Dio,
      name: "dio",
      from: DioModule,
      resolvers: {LocalStorageRepository: "secure_storage"})

//DATA LAYER
  @Register.singleton(AuthRepository,
      name: "auth_repository",
      from: AuthRestRepository,
      resolvers: {Dio: "dio"})
  @Register.singleton(GuideRepository,
      name: "guide_repository",
      from: GuideRestRepository,
      resolvers: {Dio: "dio"})
  @Register.singleton(BalanceRepopsitory,
      name: "balance_repository",
      from: BalanceRestRepository,
      resolvers: {Dio: "dio"})
  @Register.singleton(RewardRepository,
      name: "reward_repository",
      from: RewardRestRepository,
      resolvers: {Dio: "dio"})
  @Register.singleton(InformationRepository,
      name: "information_repository",
      from: InformationRestRepository,
      resolvers: {Dio: "dio"})
  @Register.singleton(NotificationRepository,
      name: "notification_repository",
      from: NotificationRestRepository,
      resolvers: {Dio: "dio"})
  @Register.singleton(FeedbackRepository,
      name: "feedback_repository",
      from: FeedbackRestRepository,
      resolvers: {Dio: "dio"})
  @Register.singleton(FreeVisitDetailRepository,
      name: "free_visit_detail_repository",
      from: FreeVisitDetailRestRepository,
      resolvers: {Dio: "dio"})
  @Register.singleton(AtributeRepository,
      name: "atribute_repository",
      from: AtributeRestRepository,
      resolvers: {Dio: "dio"})

  //PRESENTATION LAYER
  @Register.factory(FreeTicketDetailBloc, resolvers: {
    LocalStorageRepository: "secure_storage",
  })
  @Register.factory(FreeTicketUseBloc, resolvers: {
    RewardRepository: "reward_repository",
  })
  @Register.factory(InitialLoadingBloc, resolvers: {
    LocalStorageRepository: "secure_storage",
  })
  @Register.factory(NotificationBloc, resolvers: {
    NotificationRepository: "notification_repository",
  })
  @Register.factory(InformationDetailBloc, resolvers: {
    InformationRepository: "information_repository",
  })
  @Register.factory(SkemaSusukBloc, resolvers: {
    InformationRepository: "information_repository",
  })
  @Register.factory(FlowClaimSusukBloc, resolvers: {
    InformationRepository: "information_repository",
  })
  @Register.factory(PricelistProgramBloc, resolvers: {
    InformationRepository: "information_repository",
  })
  @Register.factory(PricelistProgramDetailBloc, resolvers: {
    InformationRepository: "information_repository",
  })
  @Register.factory(FeedbackBloc, resolvers: {
    FeedbackRepository: "feedback_repository",
  })
  @Register.factory(RedeemPointBloc, resolvers: {
    RewardRepository: "reward_repository",
  })
  @Register.factory(FreeTicketBloc, resolvers: {
    RewardRepository: "reward_repository",
  })
  @Register.factory(InformationBloc, resolvers: {
    InformationRepository: "information_repository",
  })
  @Register.factory(CommisionHistoryBloc, resolvers: {
    BalanceRepopsitory: "balance_repository",
    GuideRepository: "guide_repository",
    RewardRepository: "reward_repository"
  })
  @Register.factory(CommisionHistoryDetailBloc, resolvers: {
    BalanceRepopsitory: "balance_repository",
  })
  @Register.factory(ProfileUpdatePasswordBloc, resolvers: {
    AuthRepository: "auth_repository",
  })
  @Register.factory(ProfileUpdateBloc, resolvers: {
    GuideRepository: "guide_repository",
    AtributeRepository: "atribute_repository",
  })
  @Register.factory(ProfileShowBloc, resolvers: {
    GuideRepository: "guide_repository",
  })
  @Register.factory(ProfileBloc, resolvers: {
    GuideRepository: "guide_repository",
    RewardRepository: "reward_repository",
    AuthRepository: "auth_repository",
    LocalStorageRepository: "secure_storage",
  })
  @Register.factory(LoginBloc, resolvers: {
    AuthRepository: "auth_repository",
    LocalStorageRepository: "secure_storage"
  })
  @Register.factory(HomeBloc, resolvers: {
    GuideRepository: "guide_repository",
    BalanceRepopsitory: "balance_repository",
    RewardRepository: "reward_repository",
    InformationRepository: "information_repository",
    LocalStorageRepository: "secure_storage",
    NotificationRepository: "notification_repository",
    AuthRepository: "auth_repository",
  })
  @Register.factory(RegisterBloc, resolvers: {
    AuthRepository: "auth_repository",
  })
  @Register.factory(FreeVisitDetailBloc, resolvers: {
    FreeVisitDetailRepository: "free_visit_detail_repository",
  })
  @Register.factory(ProfileUpdateEmailBloc, resolvers: {
    AuthRepository: "auth_repository",
  })
  @Register.factory(ProfileUpdateUsernameBloc, resolvers: {
    AuthRepository: "auth_repository",
  })
  void configure();
}

class IosModule {
  static void setup() {
    var injection = _$Ios();
    injection.configure();
  }
}
