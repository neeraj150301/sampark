import 'package:googleapis_auth/auth_io.dart';

class AccessFirebaseToken {
  static String fMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "chatty-4c0af",
        "private_key_id": "611bf5a44ac9ec228df257164be19bfb8e3c361e",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCkaOdYTEuy1xl4\n3T6ur+fj4UdLAFBGLRdgGmIqN0Yyi63+qfFkrcuXDH8bjmDnRsMux/22WQb2cnYn\nnLyh6qyj/3BhzZZCK1Ab9rYlmFILZ/UOn2sX1V4FV8/92qXljNDTUhaONxw4UAwc\nD7KpaBnceNV9iqSFEnHi6LOyWIvetxe0p9G2A82JaLVBzo2CarfQPjTKmml7ypBX\n2EMR+8U7173EOo3mwMAHjVXOrB9EgD3giQYEPGWRIWw5tOPx6dP8+APXDFckzptX\nMfMlt0T50+1xdnc5XGuMonopxkqklJwj+9aGVjVT/56E1Y0qmBKSEe2Epsms1ihy\nbdVmKttxAgMBAAECggEACshTANpbHhbnlaLL9zyz5ID8Mh3qhdmz9mJwlPR0UwEQ\nZ5rpaRkRWL4R8YKWViCw0Rb+a5i94UibOWiZAfUAPs60RgPL0png2n6lDkTlv5gB\nLUT1CvZ8QLU0P8G43tvL/8n6zvesDwDn9GiuptfcF1ao6L+An/YYWEF69IvEW5Yz\nSvisQ+0BpudOHFU/gXhGuGXmB7VEZvCtJC5iMD2NwrmjGI46JC3HAljr65vHRU3T\nLuQjah9luGmFLMwEj83J4dfYldXbKczEzHKdpTxS7b0HKMimi2p7yi5onDkp4gNN\n24Oselze/EbCGsjQhG91NXl1LFeKzx2SVAN/lsdIqQKBgQDQO6msSscbUJKo2h4+\nBuV+3KgdsmW1Eu5JPC7+xx6rrBzUrU3CtJTxL2BEpt1SyGcJtmgR8GbM0FboS0ym\np/lnUu143+I9rwgFz2KLR8wfODVkl2wSC/KxOZOetJ0IdQVQGUe0tI1O/5HX/qcf\nwmjwhHFFguuZBHids/Ui502OiQKBgQDKH8ATvQNKLpgehKiZeVCTASyJqxwjAlvn\nhXg2FlTatUgpi5XgEfnTQmguG5Qb1lW7tlLCBBOrH8LscRJ81gNLT0tIRNPuC7lm\ngHO6hDMK5ALERl7sG8nr1ugQ1rK2EsA9z2ThIHOJJT/iLDgxOIHTHeZsS0aqR2wd\niqQ66SDrqQKBgQCIffMz+jgU0XWwtHiKU97ujxirjppYXLZQzuBHJKIYCVNEnOyR\nqejPRyylE3OTpcTUevoweBIKQq4UyfbObuBuN89tIeOcZzStCkkf3soP1Lo62359\nPdOxE3qN1vnv5zS6UjfMXWUa2S7yE/vcN4St00KkO7LOtD2TsbgHTvJpcQKBgH9S\nXslQQDlDfpmC0T3UOJhRnf+epNu8ya3e2qmfiZY3qZxaDHAYgrm8VCnvP24Fpv3W\nzOzgao9aM4yDcbTnjy2qZm7AxItoIULbWYs9aXXLyZ5gAb1Th++i8Y5h4DNnPmfx\nM8fIjF7w8vwDBOakhMs7Q4ImLP5ofUdipS9i2VT5AoGAaFMzdGNKBmXQAzustLDl\nKTLjAcg2GKIrS+2q5coU/0akrwl8wpLqwYMtruN9A42p3dOX5RQklUD2BGPqosa1\nmAuTlM1mPYVdrDE+qxDsddL+7i2iWM0Pym4Pt01jY/4MjT6nUnDCpr69oVW0o47O\n1yKW18skDgx1Mlthp8O/HIo=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-n4dvx@chatty-4c0af.iam.gserviceaccount.com",
        "client_id": "102589896920771283593",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-n4dvx%40chatty-4c0af.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      [fMessagingScope],
    );

    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
