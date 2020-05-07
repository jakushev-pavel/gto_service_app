import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/future_widget_builder/future_widget_builder.dart';
import 'package:gtoserviceapp/components/text/caption.dart';
import 'package:gtoserviceapp/components/text/headline.dart';
import 'package:gtoserviceapp/components/widgets/card_list_view.dart';
import 'package:gtoserviceapp/screens/profile/common/invite_user.dart';
import 'package:gtoserviceapp/services/repo/secretary.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';
import 'package:gtoserviceapp/services/utils/utils.dart';

class SecretaryCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Секретари"),
      ),
      body: _buildBody(),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildFutureList(),
      ],
    );
  }

  FutureWidgetBuilder<List<Secretary>> _buildFutureList() {
    return FutureWidgetBuilder(
      SecretaryRepo.I.getFromOrg(Storage.I.read(Keys.organisationId)),
      (context, List<Secretary> data) => _buildSecretaryList(data),
    );
  }

  Widget _buildSecretaryList(List<Secretary> data) {
    return CardListView(data, _buildSecretary);
  }

  Widget _buildSecretary(_, Secretary secretary) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildSecretaryInfo(secretary),
        _buildDeleteButton(secretary),
      ],
    );
  }

  Column _buildSecretaryInfo(Secretary secretary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadlineText(secretary.name),
        CaptionText(secretary.email),
        CaptionText(Utils.formatDate(DateTime.parse(secretary.dateOfBirth))),
      ],
    );
  }

  IconButton _buildDeleteButton(Secretary secretary) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () => _onDeletePressed(secretary),
    );
  }

  Widget _buildFab(context) {
    return FloatingActionButton(
      onPressed: () => _onFabPressed(context),
      child: Icon(Icons.add),
    );
  }

  _onFabPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => InviteUserScreen(
        title: "Приглашение секретаря",
        addUser: (String email) {
          return SecretaryRepo.I
              .add(Storage.I.read(Keys.organisationId), email);
        },
      ),
    ));
  }

  _onDeletePressed(Secretary secretary) {
    SecretaryRepo.I.deleteFromOrg(
      Storage.I.read(Keys.organisationId),
      secretary.secretaryOnOrganizationId,
    );
  }
}
