#!/usr/bin/perl
use strict;
use warnings;

BEGIN {
    push @INC, '.';
}

use Data::Dumper;

use Token;
use Reserved;
use Statement;
use Program;

my %_reserved = %Reserved::reserved;

# enum [[[

use enum qw(
    Number
    Identifier
    Equals
    OpenParen
    CloseParen
    BinaryOperator
    SemiColon
    DoubleQuote
    SingleQuote
    Reserved
    EOF
);

# ]]]

my $temp = [];
my $prog = Program->new('Program', $temp);

sub token { # [[[
    my ($val, $type) = @_;

    my $token = Token->new(
        value     => $val,
        TokenType => $type
    );

    return $token;
}
# ]]]

sub isalpha { # [[[
    return $_[0] =~ m/^[a-zA-Z]+$/;
}
# ]]]

sub isint { # [[[
    return $_[0] =~ m/^[0-9]+$/;
}
# ]]]

sub isskippable { # [[[
    return $_[0] =~ m/^\s$/;
}
# ]]]

sub tokenize { # [[[
    my @src = split //, shift;
    my @tokens;

    while (@src) {
        # Single character tokens
        if ($src[0] eq '(') {
            push @tokens, token(shift @src, OpenParen);
        }
        elsif ($src[0] eq ')') {
            push @tokens, token(shift @src, CloseParen);
        }
        elsif ($src[0] eq '=') {
            push @tokens, token(shift @src, Equals);
        }
        elsif ($src[0] eq ';') {
            push @tokens, token(shift @src, SemiColon);
        }
        elsif ($src[0] eq '"') {
            push @tokens, token(shift @src, DoubleQuote);
        }
        elsif ($src[0] eq "'") {
            push @tokens, token(shift @src, SingleQuote);
        }
        elsif ($src[0] =~ m!^[-+*/]$!) {
            push @tokens, token(shift @src, BinaryOperator);
        } else {

            # Multi character tokens
            if (isint($src[0])) {
                my $num = shift @src;
                while (@src && isint($src[0])) {
                    $num .= shift @src;
                }

                push @tokens, token($num, Number);
                next;
            }
            elsif (isalpha($src[0])) {
                my $ident = shift @src;
                while (@src && isalpha($src[0])) {
                    $ident .= shift @src;
                }

                push @tokens, token($ident, $_reserved{$ident} ? Reserved : Identifier);
                next;
            }
            elsif (isskippable($src[0])) {
                shift @src;
                next;
            }
            else {
                die "Unrecognized character: $src[0]\n";
            }
        }
    }

    push @tokens, token("EndOfFile", EOF);

    print Dumper @tokens;

    return @tokens
}
# ]]]

open (my $file, '<', './test.txt') or die $!;

my $F = do { local $/; <$file> };

tokenize($F);
