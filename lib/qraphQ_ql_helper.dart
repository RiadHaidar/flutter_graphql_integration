import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLHelper {
  Future<GraphQLClient> initilize() async {
    final HttpLink httpLink = HttpLink(
      'https://rickandmortyapi.com/graphql',
    );

    final GraphQLClient graphqlClient = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );
    return graphqlClient;
  }

  void fetchData(GraphQLClient graphQLClient) async {
    QueryResult queryResult = await graphQLClient.query(
      QueryOptions(
        document: gql(
          """query {
  characters() {
    results {
      name
      image 
    }
  }
  
}""",
        ),
      ),
    );

    print(queryResult.data!['characters']['results']);
  }

  void getData() {
    initilize().then((value) {
      fetchData(value);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
