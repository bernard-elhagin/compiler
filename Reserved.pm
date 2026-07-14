package Reserved;

use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(@reserved);

our %reserved;

%reserved = (
    let  => 1,
    exit => 1,
);

return 1;
