package PWA::WeatherClient;

our $VERSION = '0.01';

=head1 NAME

PWA::WeatherClient - placeholder for the PWA of the client

=head1 TO DO

=over 4

=item *

Periodically refresh weather data if it is outdated

=item *

Implement location selection via a C<< <datalist> >> list of the (5000)
locations available in the MOSMIX set. This means no (client side)
search/ordering by location/vincinity, but it also means very little code
outside of what is needed to create/update the C<< <datalist> >> items.

Maybe these locations can be (one-time) cached client-side as JSON and
used to construct the template for location selection instead?!

=item *

Use the background sync API instead of (always) doing a HTTP request

This would make fetching the updated data more resilient and power saving
in the cases where the browser supports the Background Sync API. Currently
this means using Chrome, as Firefox does not support the API.

=back

=cut

1;
