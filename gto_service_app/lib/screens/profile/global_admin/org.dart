import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/widgets/card_list_view.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/widgets/dialogs/yes_no_dialog.dart';
import 'package:gtoserviceapp/components/widgets/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/widgets/field.dart';
import 'package:gtoserviceapp/components/widgets/future_widget_builder.dart';
import 'package:gtoserviceapp/components/widgets/text/caption.dart';
import 'package:gtoserviceapp/screens/common/invite_user.dart';
import 'package:gtoserviceapp/screens/profile/global_admin/add_edit_org.dart';
import 'package:gtoserviceapp/services/repo/local_admin.dart';
import 'package:gtoserviceapp/services/repo/org.dart';

class OrganisationScreen extends StatelessWidget {
  final int _orgId;

  OrganisationScreen(this._orgId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFAB(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Организация"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _onEditPressed(context),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _onDeletePressed(context),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildFutureOrgCard(context),
        _buildLocalAdminsListHeader(context),
        _buildFutureLocalAdminsList(context),
        SizedBox(height: 48),
      ],
    );
  }

  Widget _buildFutureOrgCard(context) {
    return FutureWidgetBuilder(OrgRepo.I.get(_orgId), _buildOrgCard);
  }

  Widget _buildOrgCard(context, Organisation org) {
    return CardPadding(
      child: ExpandedHorizontally(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildName(org, context),
            _buildTotalEventsCount(org),
            _buildActiveEventsCount(org),
            Field("Aдрес", child: Text(org.address)),
            Field("Ответственный", child: Text(org.leader)),
            Field("Номер телефона", child: Text(org.phoneNumber)),
            Field("ОГРН", child: Text(org.oQRN)),
            Field("Лицевой счёт", child: Text(org.paymentAccount)),
            Field("Филиал", child: Text(org.branch)),
            Field("БИК", child: Text(org.bik)),
            Field("Расчётный счёт", child: Text(org.correspondentAccount)),
          ],
        ),
      ),
    );
  }

  Text _buildName(Organisation org, context) {
    return Text(
      org.name ?? "",
      style: Theme.of(context).textTheme.headline,
    );
  }

  _onEditPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return AddEditOrgScreen(orgId: _orgId);
    }));
  }

  _onDeletePressed(context) {
    showDialog(context: context, child: _buildConfirmDeleteDialog(context));
  }

  Widget _buildConfirmDeleteDialog(context) {
    return YesNoDialog("Вы уверены?", () async {
      var result = OrgRepo.I.delete(this._orgId);
      ErrorDialog.showOnFutureError(context, result);

      await result;
      Navigator.of(context).pop();
    });
  }

  _buildTotalEventsCount(Organisation org) {
    return Text("Всего мероприятий: ${org.countOfAllEvents}");
  }

  _buildActiveEventsCount(Organisation org) {
    return Text("Активных мероприятий: ${org.countOfActiveEvents}");
  }

  Widget _buildLocalAdminsListHeader(context) {
    return Padding(
      padding: DefaultMargin,
      child: Text(
        "Администраторы:",
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget _buildFutureLocalAdminsList(context) {
    return FutureWidgetBuilder(
        LocalAdminRepo.I.getAll(_orgId),
        (_, List<LocalAdmin> localAdmins) =>
            _buildLocalAdminsList(localAdmins));
  }

  Widget _buildLocalAdminsList(List<LocalAdmin> localAdmins) {
    return CardListView(localAdmins, _buildLocalAdmin);
  }

  Widget _buildLocalAdmin(context, LocalAdmin localAdmin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(localAdmin.name),
            CaptionText(localAdmin.email),
          ],
        ),
        _buildDeleteLocalAdminButton(context, localAdmin),
      ],
    );
  }

  Widget _buildDeleteLocalAdminButton(context, LocalAdmin localAdmin) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          child: YesNoDialog(
            "Удалить ${localAdmin.name} из списка администраторов?",
            () => _onDeleteLocalAdminPressed(localAdmin),
          ),
        );
      },
    );
  }

  _onDeleteLocalAdminPressed(LocalAdmin localAdmin) {
    LocalAdminRepo.I.delete(_orgId, localAdmin.id);
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _onAddLocalAdminPressed(context),
    );
  }

  _onAddLocalAdminPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return InviteUserScreen(
        title: "Приглашение администратора",
        addUser: (String email) {
          return LocalAdminRepo.I.add(_orgId, email);
        },
      );
    }));
  }
}
