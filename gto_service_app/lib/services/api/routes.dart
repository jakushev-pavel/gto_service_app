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
  OrgSecretaries,
  EventSecretaries,
  SecretaryExisting,
  OrgSecretary,
  EventSecretary,

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
      case Routes.UserEvents:
        return "/event/forUser";
      case Routes.Events:
        return "/organization/{orgId}/event";
      case Routes.Event:
        return "/organization/{orgId}/event/{eventId}";
      case Routes.EventApply:
        return "/event/{eventId}/apply";
      case Routes.EventTeamParticipants:
        return "/team/{teamId}/participant";
      case Routes.EventParticipants:
        return "/event/{eventId}/participant";
      case Routes.EventParticipant:
        return "/participant/{participantId}";
      case Routes.Invite:
        return "/auth/invite";
      case Routes.Confirm:
        return "/auth/confirmAccount";
      case Routes.Login:
        return "/auth/login";
      case Routes.Refresh:
        return "/auth/refresh";
      case Routes.Info:
        return "/auth/info";
      case Routes.LocalAdmins:
        return "/organization/{orgId}/localAdmin";
      case Routes.LocalAdmin:
        return "/organization/{orgId}/localAdmin/{localAdminId}";
      case Routes.LocalAdminExisting:
        return "/organization/{orgId}/localAdmin/existingAccount";
      case Routes.Organizations:
        return "/organization";
      case Routes.Organization:
        return "/organization/{orgId}";
      case Routes.Role:
        return "/role";
      case Routes.OrgSecretaries:
        return "/organization/{orgId}/secretary";
      case Routes.EventSecretaries:
        return "/organization/{orgId}/event/{eventId}/secretary";
      case Routes.SecretaryExisting:
        return "/organization/{orgId}/event/{eventId}/secretary/existingAccount";
      case Routes.OrgSecretary:
        return "/organization/{orgId}/secretary/{secretaryId}";
      case Routes.EventSecretary:
        return "/organization/{orgId}/event/{eventId}/secretary/{secretaryId}";
      case Routes.EventTeams:
        return "/organization/{orgId}/event/{eventId}/team";
      case Routes.EventTeam:
        return "/organization/{orgId}/event/{eventId}/team/{teamId}";
      case Routes.ConfirmTeam:
        return "/team/{teamId}/confirm";
      case Routes.UserTeams:
        return "/team";
      case Routes.Team:
        return "/team/{teamId}";
      case Routes.TeamLeads:
        return "/team/{teamId}/teamLead";
      case Routes.TeamLead:
        return "/teamLead/{teamLeadId}";
      case Routes.Trial:
        return "/trial/{age}/{gender}";
      case Routes.TrialSecondaryResult:
        return "/trial/{trialId}/firstResult?firstResult={primaryResult}";
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
