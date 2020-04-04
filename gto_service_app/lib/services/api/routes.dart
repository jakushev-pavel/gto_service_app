import 'package:gtoserviceapp/models/calculator.dart';
import 'package:gtoserviceapp/models/gender.dart';

enum Routes {
  // Event
  SecretaryEvents,
  UserEvents,
  Events,
  Event,

  // ParticipantEvent
  EventApply,
  EventTeamParticipants,
  EventParticipants,
  EventParticipant,

  // User
  Invite,
  Confirm,
  Login,
  Refresh,
  Info,

  // LocalAdmin
  LocalAdmins,
  LocalAdmin,
  LocalAdminExisting,

  // Organization
  Organizations,
  Organization,

  // Role
  Role,

  // Secretary
  Secretaries,
  SecretaryExisting,
  Secretary,

  // Team
  EventTeams,
  EventTeam,
  ConfirmTeam,
  UserTeams,
  Team,

  // TeamLead
  TeamLeads,
  TeamLead,

  // Trial
  Trial,
  TrialSecondaryResult,
}

extension RoutesEx on Routes {
  String toStr() {
    switch (this) {
      case Routes.SecretaryEvents:
        return "/event/forSecretary";
        break;
      case Routes.UserEvents:
        return "/event/forUser";
        break;
      case Routes.Events:
        return "/organization/{orgId}/event";
        break;
      case Routes.Event:
        return "/organization/{orgId}/event/{eventId}";
        break;
      case Routes.EventApply:
        return "/event/{eventId}/apply";
        break;
      case Routes.EventTeamParticipants:
        return "/team/{teamId}/participant";
        break;
      case Routes.EventParticipants:
        return "/event/{eventId}/participant";
        break;
      case Routes.EventParticipant:
        return "/participant/{participantId}";
        break;
      case Routes.Invite:
        return "/auth/invite";
        break;
      case Routes.Confirm:
        return "/auth/confirmAccount";
        break;
      case Routes.Login:
        return "/auth/login";
        break;
      case Routes.Refresh:
        return "/auth/refresh";
        break;
      case Routes.Info:
        return "/auth/info";
        break;
      case Routes.LocalAdmins:
        return "/organization/{orgId}/localAdmin";
        break;
      case Routes.LocalAdmin:
        return "/organization/{orgId}/localAdmin/{localAdminId}";
        break;
      case Routes.LocalAdminExisting:
        return "/organization/{orgId}/localAdmin/existingAccount";
        break;
      case Routes.Organizations:
        return "/organization";
        break;
      case Routes.Organization:
        return "/organization/{orgId}";
        break;
      case Routes.Role:
        return "/role";
        break;
      case Routes.Secretaries:
        return "/organization/{orgId}/event/{eventId}/secretary";
        break;
      case Routes.SecretaryExisting:
        return "/organization/{orgId}/event/{eventId}/secretary/existingAccount";
        break;
      case Routes.Secretary:
        return "/organization/{orgId}/event/{eventId}/secretary/{secretaryId}";
        break;
      case Routes.EventTeams:
        return "/organization/{orgId}/event/{eventId}/team";
        break;
      case Routes.EventTeam:
        return "/organization/{orgId}/event/{eventId}/team/{teamId}";
        break;
      case Routes.ConfirmTeam:
        return "/team/{teamId}/confirm";
        break;
      case Routes.UserTeams:
        return "/team";
        break;
      case Routes.Team:
        return "/team/{teamId}";
        break;
      case Routes.TeamLeads:
        return "/team/{teamId}/teamLead";
        break;
      case Routes.TeamLead:
        return "/teamLead/{teamLeadId}";
        break;
      case Routes.Trial:
        return "/trial/{age}/{gender}";
        break;
      case Routes.TrialSecondaryResult:
        return "/trial/{trialId}/firstResult?firstResult={primaryResult}";
        break;
      default:
        throw Exception("Invlid route");
    }
  }

  String withArgs({
    String orgId,
    String eventId,
    String teamId,
    String participantId,
    String secretaryId,
    String localAdminId,
    String teamLeadId,
    int age,
    Gender gender,
    int trialId,
    int primaryResult,
  }) {
    return _withArgs({
      "orgId": orgId,
      "eventId": eventId,
      "teamId": teamId,
      "participantId": participantId,
      "secretaryId": secretaryId,
      "localAdminId": localAdminId,
      "teamLeadId": teamLeadId,
      "age": age?.toString(),
      "gender": gender?.toInt().toString(),
      "trialId": trialId?.toString(),
      "primaryResult": primaryResult?.toString(),
    });
  }

  String _withArgs(Map<String, String> args) {
    var route = this.toStr();
    args.forEach((from, to) {
      if (to == null) {
        return;
      }
      route = route.replaceAll("{$from}", to);
    });

    return route;
  }
}
