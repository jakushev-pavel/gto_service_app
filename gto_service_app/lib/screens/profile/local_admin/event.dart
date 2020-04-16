import 'package:flutter/material.dart';
import 'package:gtoserviceapp/components/failure/failure.dart';
import 'package:gtoserviceapp/components/layout/expanded_horizontally.dart';
import 'package:gtoserviceapp/components/layout/shrunk_vertically.dart';
import 'package:gtoserviceapp/components/text/date.dart';
import 'package:gtoserviceapp/components/text/headline.dart';
import 'package:gtoserviceapp/components/widgets/card_padding.dart';
import 'package:gtoserviceapp/components/widgets/field.dart';
import 'package:gtoserviceapp/models/event.dart';
import 'package:gtoserviceapp/services/repo/event.dart';
import 'package:gtoserviceapp/services/storage/keys.dart';
import 'package:gtoserviceapp/services/storage/storage.dart';

class EventScreen extends StatelessWidget {
  final int _id;

  EventScreen(this._id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildFutureEventCard(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Мероприятие"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: null,
        ),
      ],
    );
  }

  Widget _buildFutureEventCard(context) {
    return FutureBuilder(
      future: EventRepo.I.get(Storage.I.read(Keys.organisationId), _id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _buildEventCard(context, snapshot.data);
        }
        if (snapshot.hasError) {
          return Failure(snapshot.error);
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildEventCard(context, Event event) {
    return ShrunkVertically(
      child: ExpandedHorizontally(
        child: CardPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeadlineText(event.name),
              Text(event.description),
              Row(
                children: <Widget>[
                  Field("Начало", child: DateText(event.startDate)),
                  SizedBox(width: 16),
                  Field("Конец", child: DateText(event.expirationDate)),
                ],
              ),
              Field("Статус", child: Text(event.status)),
            ],
          ),
        ),
      ),
    );
  }
}
