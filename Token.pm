package Token;

use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    return bless { %args }, $class;
}

return 1;
