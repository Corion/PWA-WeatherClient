#!perl
use strict;
use warnings;
use Mojolicious::Lite;

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

# Start the Mojolicious command system
app->start;
