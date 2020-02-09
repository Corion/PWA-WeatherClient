#!perl
use strict;
use warnings;
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json encode_json);
use charnames ':full';

use FindBin;
use lib "$FindBin::Bin/../../Weather-MOSMIX/lib";
use Weather::MOSMIX;

push @{app->static->paths} => "$FindBin::Bin/../public";

my $w = Weather::MOSMIX->new(
    dsn => "dbi:SQLite:dbname=$FindBin::Bin/../../Weather-MOSMIX/db/forecast.sqlite",
);

get '/' => sub {
    my $c = shift;
    return $c->redirect_to('index.html');
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
