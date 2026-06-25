import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/frame/frame.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/routing/undefined_view.dart';
import 'package:srigunting_app/src/ui/app/commmision_history_detail/commision_history_detail_screen.dart';
import 'package:srigunting_app/src/ui/app/commision_history/commision_history_screen.dart';
import 'package:srigunting_app/src/ui/app/contact_us/contact_us_screen.dart';
import 'package:srigunting_app/src/ui/app/feedback/feedback_screen.dart';
import 'package:srigunting_app/src/ui/app/pricelist_program/pricelist_program_screen.dart';
import 'package:srigunting_app/src/ui/app/pricelist_program_detail/pricelist_program_detail_screen.dart';
import 'package:srigunting_app/src/ui/app/free_ticket/free_ticket_screen.dart';
import 'package:srigunting_app/src/ui/app/free_ticket_detail/free_ticket_detail_screen.dart';
import 'package:srigunting_app/src/ui/app/free_ticket_use/free_ticket_use_screen.dart';
import 'package:srigunting_app/src/ui/app/free_visit_detail/free_visit_detail_screen.dart';
import 'package:srigunting_app/src/ui/app/home/home_screen.dart';
import 'package:srigunting_app/src/ui/app/information/information_screen.dart';
import 'package:srigunting_app/src/ui/app/information_detail/information_detail_screen.dart';
import 'package:srigunting_app/src/ui/app/notification/notification_screen.dart';
import 'package:srigunting_app/src/ui/app/profile/profile_screen.dart';
import 'package:srigunting_app/src/ui/app/profile_show/profile_show_screen.dart';
import 'package:srigunting_app/src/ui/app/profile_update/profile_update_screen.dart';
import 'package:srigunting_app/src/ui/app/profile_update_email/profile_update_email_screen.dart';
import 'package:srigunting_app/src/ui/app/profile_update_username/profile_update_username_screen.dart';
import 'package:srigunting_app/src/ui/app/profile_update_password/profile_update_password_screen.dart';
import 'package:srigunting_app/src/ui/app/redeem_point/redeem_point_screen.dart';
import 'package:srigunting_app/src/ui/app/redeem_point_detail/redeem_point_detail_second_screen.dart';
import 'package:srigunting_app/src/ui/app/reward_and_point/reward_and_point_screen.dart';
import 'package:srigunting_app/src/ui/app/reward_and_point_detail/reward_and_point_detail_screen.dart';
import 'package:srigunting_app/src/ui/app/skema_susuk/skema_susuk_screen.dart';
import 'package:srigunting_app/src/ui/app/flow_claim_susuk/flow_claim_susuk_screen.dart';
import 'package:srigunting_app/src/ui/forgot_password/forgot_password_screen.dart';
import 'package:srigunting_app/src/ui/initial_loading/initial_loading_screen.dart';
import 'package:srigunting_app/src/ui/initial_page/initial_page_screen.dart';
import 'package:srigunting_app/src/ui/login/login_screen.dart';
import 'package:srigunting_app/src/ui/register/register_screen.dart';

class RoutingApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name!.startsWith(Routing.APP)) {}

    if (settings.name == Routing.INITIAL_ROUTE) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) => const Frame(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.INITIAL_PAGE) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const InitialPageScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.INITIAL_LOADING) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const InitialLoadingScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.LOGIN) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) => const LoginScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }
    if (settings.name == Routing.REGISTER) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const RegisterScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.FORGOT_PASSWORD) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const ForgotPasswordScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.APP) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) => const HomeScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.COMMISION_HISTORY) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const CommisionHistoryScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.CLAIMED_DETAIL) {
      var args = settings.arguments as Map;
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            CommisionHistoryDetailScreen(
          transaction: args['transaction'],
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.FREE_VISIT_DETAIL) {
      var args = settings.arguments as Map;
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) => FreeVisitDetailScreen(
          dataFreevisit: args['free_visit'],
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.PROFILE) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) => const ProfileScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.PROFILE_SHOW) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const ProfileShowScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.PROFILE_UPDATE) {
      var args = settings.arguments as Map;
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) => ProfileUpdateScreen(
          guide: args['guide'],
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.PROFILE_UPDATE_EMAIL) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const ProfileUpdateEmailScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.PROFILE_UPDATE_USERNAME) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const ProfileUpdateUsernameScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.RESET_PASSWORD) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const ProfileUpdatePasswordScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.NOTIFICATION) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const NotificationScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.REWARD_AND_POINT) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const RewardAndPointScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.REWARD_AND_POINT_DETAIL) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const RewardAndPointDetailScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.INFORMATIONS) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const InformationScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.INFORMATION) {
      var args = settings.arguments as Map;
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            InformationDetailScreen(slug: args['slug']),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.CONTACT_US) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const ContactUsScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.FEEDBACK) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const FeedbackScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.SKEMA_SUSUK) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const SkemaSusukScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.FLOW_KLAIM) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const FlowClaimSusukScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.PRICELIST_PROGRAM) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const PricelistProgramScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.PRICELIST_PROGRAM_DETAIL) {
      var args = settings.arguments as Map;
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            PricelistProgramDetailScreen(
          media: args['media'],
          title: args['title'],
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.FREE_TICKET) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const FreeTicketScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.FREE_TICKET_USE) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const FreeTicketUseScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.FREE_TICKET_DETAIL) {
      var args = settings.arguments as Map;
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            FreeTicketDetailScreen(
          freeVisit: args['free_visit'],
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.REDEEM_POINT) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const RedeemPointScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    if (settings.name == Routing.REDEEM_POINT_DETAIL) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            const RedeemPointDetailSecondScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    return MaterialPageRoute(
      builder: (_) => UndefinedView(
        routeName: settings.name ?? "-",
      ),
    );
  }
}
