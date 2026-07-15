package Statement;

use strict;
use warnings;

sub new {
    my $class = shift;

    my $self = {
        kind => shift
    };

    bless $self, $class;

    return $self;
}

return 1;
