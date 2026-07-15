package Program;

use base 'Statement';

sub new {
    my $class = shift;

    my $self = $class->SUPER::new(@_);
    @{ $self->{body} } = shift;

    return $self;
}

return 1;
