import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/future_widget_builder/future_widget_builder.dart';
import 'package:gtoserviceapp/components/text/caption.dart';
import 'package:gtoserviceapp/components/text/headline.dart';
import 'package:gtoserviceapp/components/widgets/card_list_view.dart';
import 'package:gtoserviceapp/services/repo/secretary.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class SecretaryCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Секретари"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        SizedBox(),
        _buildFutureList(),
      ],
    );
  }

  FutureWidgetBuilder<List<Secretary>> _buildFutureList() {
    return FutureWidgetBuilder(
      SecretaryRepo.I.getFromOrg(Storage.I.read(Keys.organisationId)),
      (List<Secretary> data) => _buildSecretaryList(data),
    );
  }

  Widget _buildSecretaryList(List<Secretary> data) {
    return CardListView(data, _buildSecretary);
  }

  Widget _buildSecretary(Secretary secretary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadlineText(secretary.name),
        CaptionText(secretary.email)
      ],
    );
  }
}
