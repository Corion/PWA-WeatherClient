package PWA::WeatherClient;

our $VERSION = '0.01';

=head1 NAME

PWA::WeatherClient - placeholder for the PWA of the client

=head1 TO DO

=over 4

=item *

Use the background sync API instead of (always) doing a HTTP request

This would make fetching the updated data more resilient and power saving
in the cases where the browser supports the Background Sync API. Currently
this means using Chrome, as Firefox does not support the API.

=back

=cut

1;
