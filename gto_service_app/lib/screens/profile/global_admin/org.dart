import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/dialogs/yes_no_dialog.dart';
import 'package:gtoserviceapp/components/failure/failure.dart';
import 'package:gtoserviceapp/components/layout/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/text/caption.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/field.dart';
import 'package:gtoserviceapp/screens/profile/global_admin/add_edit_org.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/repo/local_admin.dart';
import 'package:gtoserviceapp/services/repo/org.dart';

class OrganisationScreen extends StatelessWidget {
  final String _id;

  OrganisationScreen(this._id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildFutureOrgCard(context),
        _buildLocalAdminsListHeader(context),
        _buildFutureLocalAdminsList(context),
      ],
    );
  }

  Widget _buildFutureOrgCard(context) {
    return FutureBuilder(
      future: OrgRepo.I.get(_id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _buildOrgCard(context, snapshot.data);
        }
        if (snapshot.hasError) {
          return Failure(snapshot.error);
        }

        return CircularProgressIndicator();
      },
    );
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
      return AddEditOrgScreen(orgId: _id);
    }));
  }

  _onDeletePressed(context) {
    showDialog(context: context, child: _buildConfirmDeleteDialog(context));
  }

  Widget _buildConfirmDeleteDialog(context) {
    return YesNoDialog("Вы уверены?", () async {
      var result = OrgRepo.I.delete(this._id);
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
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Text(
        "Администраторы:",
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget _buildFutureLocalAdminsList(context) {
    return FutureBuilder(
      future: LocalAdminRepo.I.getAll(_id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildLocalAdminsList(snapshot.data);
        }
        if (snapshot.hasError) {
          return Failure(snapshot.error);
        }

        return SizedBox.shrink(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildLocalAdminsList(List<LocalAdmin> localAdmins) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        if (index >= localAdmins.length) {
          return null;
        }

        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: _buildLocalAdmin(context, localAdmins[index]),
        );
      },
    );
  }

  Widget _buildLocalAdmin(context, LocalAdmin localAdmin) {
    return CardPadding(
      child: Row(
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
      ),
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
            _onDeleteLocalAdminPressed(localAdmin),
          ),
        );
      },
    );
  }

  _onDeleteLocalAdminPressed(LocalAdmin localAdmin) {
    LocalAdminRepo.I.delete(_id, localAdmin.localAdminId.toString());
  }
}
