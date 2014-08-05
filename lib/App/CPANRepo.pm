package App::CPANRepo;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use MetaCPAN::Client 1.005000;

use Class::Accessor::Lite::Lazy (
    new => 1,
    ro_lazy => {
        _client => sub { MetaCPAN::Client->new },
    },
);

sub resolve_repo {
    my ($self, $name) = @_;

    my $repo;
    eval {
        my $module = $self->_client->module($name);
        my $release = $self->_client->release($module->distribution);
        if ($release->resources->{repository}) {
            $repo = $release->resources->{repository}{url};
        }
    };

    return $repo;
}

sub run {
    my ($class, @argv) = @_;

    my $self = $class->new;
    for my $module (@argv) {
        print( ($self->resolve_repo($module) || '') . "\n");
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

App::CPANRepo - It's new $module

=head1 SYNOPSIS

    use App::CPANRepo;

=head1 DESCRIPTION

App::CPANRepo is ...

=head1 LICENSE

Copyright (C) Songmu.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Songmu E<lt>y.songmu@gmail.comE<gt>

=cut

