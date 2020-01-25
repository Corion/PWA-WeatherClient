#!perl
use strict;
use warnings;
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json encode_json);
use charnames ':full';

use lib '../Weather-MOSMIX/lib';
use Weather::MOSMIX;

my $w = Weather::MOSMIX->new(
    dsn => 'dbi:SQLite:dbname=../Weather-MOSMIX/db/forecast.sqlite',
);

# Route with placeholder
#get '/:foo' => sub {
#    my $c   = shift;
#    my $foo = $c->param('foo');
#    $c->render(text => "Hello from $foo.");
#};
get '/' => sub {
    my $c = shift;
    $c->reply->static('index.html');
};

post '/forecast' => sub {
    my $c = shift;
    my $query = decode_json( $c->req->body );
    my @locations = @{ $query->{'locations'} };

    my @res;
    for my $l (@locations) {
        my $f =
            $w->forecast_dbh(latitude => $l->{latitude}, longitude => $l->{longitude} );
        my $out = $w->format_forecast_dbh( $f, 6 );
        #$out->[0]->{utf8} = "\N{CHECK MARK}";
        push @res, $out;
    };
    my $res = { forecast => \@res };
    $c->render( json => $res );
};



# Start the Mojolicious command system
app->start;
