import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/dialogs/error_dialog.dart';
import 'package:gtoserviceapp/components/dialogs/yes_no_dialog.dart';
import 'package:gtoserviceapp/components/layout/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/layout/shrunk_vertically.dart';
import 'package:gtoserviceapp/components/text/caption.dart';
import 'package:gtoserviceapp/screens/profile/global_admin/add_edit_org.dart';
import 'package:gtoserviceapp/services/api/api.dart';
import 'package:gtoserviceapp/services/api/models.dart';
import 'package:gtoserviceapp/services/repo/org.dart';

class OrganisationScreen extends StatelessWidget {
  final String _id;

  OrganisationScreen(this._id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildFutureOrg(context),
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

  Widget _buildFutureOrg(context) {
    var org = OrgRepo.I.get(_id);
    ErrorDialog.showOnFutureError(context, org);

    return FutureBuilder(
      future: org,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _buildOrg(context, snapshot.data);
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildOrg(context, Organisation org) {
    return ShrunkVertically(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ExpandedHorizontally(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  org.name ?? "",
                  style: Theme.of(context).textTheme.headline,
                ),
                _buildField("Aдрес", org.address),
                _buildField("Ответственный", org.leader),
                _buildField("Номер телефона", org.phoneNumber),
                _buildField("ОГРН", org.oQRN),
                _buildField("Лицевой счёт", org.paymentAccount),
                _buildField("Филиал", org.branch),
                _buildField("БИК", org.bik),
                _buildField("Расчётный счёт", org.correspondentAccount),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String caption, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CaptionText(caption),
          Text(value ?? ""),
        ],
      ),
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
    return YesNoDialog("Вы уверены?", () {
      var result = OrgRepo.I.delete(this._id);
      ErrorDialog.showOnFutureError(context, result);

      Navigator.of(context).pop();
    });
  }
}
